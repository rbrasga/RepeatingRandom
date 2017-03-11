#FIO LOG File Format:
#time, rate/latency, data direction, block size

import os, sys, time, datetime, socket
from subprocess import Popen,PIPE

# Import Graphing Tools
import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
import numpy as np


def execute():
	#Current time in a human readable format
	#Name of the .csv file with the current date and time
	#Check whether the filename with that name exist or not in the path given
	#If the filename does not exist, then open the .csv file and write the first row
	#if sys.platform == "win32":
	str_time = ""
	temp = 0
	index_serial=0
	index = 0
	GLOBALINDEX=1
	
	#Graph all BW logs on the same graph
	ending = "bw.log"
	map = find_map(ending)
	graph_log(map,ending, False)
	graph_log(map,ending, True)
	
	#Graph all IOPs logs on the same graph
	ending = "iops.log"
	map = find_map(ending)
	graph_log(map, ending, False)
	graph_log(map, ending, True)

	
def find_map(ending):
	map = dict()
	for filename in os.listdir('.'):
		if filename.endswith(ending):
			title=filename.split(".")[0]
			title=title.strip()
			if title.endswith("_100p_"+ending.split(".")[0]):
				length=-1*len("_100p_"+ending.split(".")[0])
				title = title[:length]
			elif title.endswith("_"+ending.split(".")[0]):
				length=-1*len("_"+ending.split(".")[0])
				title = title[:length]
			readfile = open(filename, 'r')
			array=[]
			for line in readfile:
				tmpstr = line.split(",")
				if tmpstr != None:
					#print tmpstr
					rate=int(tmpstr[1])
					array.append(rate)
			map[title] = array
	return map

	
def graph_lines(array, title):
	COLORARRAY=['b','g','r','c','m','y']
	index=0
	fig = plt.figure()
	xtime=range(0,len(array))
	yvalues=sorted(array)
	plt.plot(xtime, yvalues, COLORARRAY[index%6], label=title)
	#legend = fig.legend(loc='upper center', shadow=True)
	plt.xlabel('Sorted Order')
	plt.title('Irvine Lab - %s' % title)
	plt.grid(True)
	
	now = datetime.datetime.now()
	currentDate = now.strftime("%Y-%m-%d_%H%M")
	fig.savefig('graph_%s_%s.png' % (title,currentDate))
	
	plt.close()
	
	
def graph_log(map, title, SORTED):
	COLORARRAY=['b','g','r','c','m','y']
	index=0
	
	cm = plt.get_cmap('gist_rainbow')
	fig = plt.figure()
	fig.set_size_inches(23, 16)
	ax = plt.subplot(111)
	NUM_COLORS = len(map.keys())
	ax.set_color_cycle([cm(1.*i/NUM_COLORS) for i in range(NUM_COLORS)])
	
	for key in map.keys():
		#if index < 6:
		array=map[key]
		xtime=range(0,len(array))
		if SORTED == True:
			yvalues=sorted(array)
			plt.plot(xtime, yvalues, COLORARRAY[index%6], label=key)
		else:
			yvalues=array
			plt.plot(xtime, yvalues, COLORARRAY[index%6], label=key)
		#else:
		#	print "[Error] Index is > 6, filename:", key, "is being ignored"
		index+=1
	
	# Shrink current axis's height by 10% on the bottom
	box = ax.get_position()
	ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])

	# Put a legend below current axis
	ax.legend(loc='center left', bbox_to_anchor=(1, 0.5))
	if SORTED == True:
		plt.xlabel('Sorted Order')
	else:
		plt.xlabel('Request Number')
	
	plt.title('Irvine Lab - %s' % title)
	plt.grid(True)
	now = datetime.datetime.now()
	currentDate = now.strftime("%Y-%m-%d_%H%M")
	if SORTED == True:
		fig.savefig('SORTED-graph_%s_%s.png' % (title,currentDate), dpi=80)
	else:
		fig.savefig('graph_%s_%s.png' % (title,currentDate), dpi=80)
	
	
	plt.close()
	
	
if __name__ == "__main__":
	execute()