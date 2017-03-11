blocksize=$1
filename1=seq_${blocksize}
filename2=rand_norep_${blocksize}
filename3=rand_rep_${blocksize}
# You must define a valid path to your SSD
#ssdpath=/dev/sdX

#Secure Erase
sg_raw -r 1k $ssdpath 48 02 00 00 00 00 00 00 00 00
sleep 300

#Repeating Random
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p1 --write_iops_log=${filename3}_p1 --name=run1 --size=100% >> ${filename3}.out 2>&1
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p2 --write_iops_log=${filename3}_p2 --name=run1 --size=100% >> ${filename3}.out 2>&1
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p3 --write_iops_log=${filename3}_p3 --name=run1 --size=100% >> ${filename3}.out 2>&1
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p4 --write_iops_log=${filename3}_p4 --name=run1 --size=100% >> ${filename3}.out 2>&1
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p5 --write_iops_log=${filename3}_p5 --name=run1 --size=100% >> ${filename3}.out 2>&1
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p6 --write_iops_log=${filename3}_p6 --name=run1 --size=100% >> ${filename3}.out 2>&1
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p7 --write_iops_log=${filename3}_p7 --name=run1 --size=100% >> ${filename3}.out 2>&1
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p8 --write_iops_log=${filename3}_p8 --name=run1 --size=100% >> ${filename3}.out 2>&1
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p9 --write_iops_log=${filename3}_p9 --name=run1 --size=100% >> ${filename3}.out 2>&1
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=1 --rw=randwrite --filename=$ssdpath --write_bw_log=${filename3}_p10 --write_iops_log=${filename3}_p10 --name=run1 --size=100% >> ${filename3}.out 2>&1

#Secure Erase
sg_raw -r 1k $ssdpath 48 02 00 00 00 00 00 00 00 00
sleep 300

#Sequential
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --rw=write --filename=$ssdpath --write_bw_log=${filename1} --write_iops_log=${filename1} --name=run1 --size=100% --stonewall --name=run2 --size=100% --stonewall --name=run3 --size=100% --stonewall --name=run4 --size=100% --stonewall --name=run5 --size=100% --stonewall --name=run6 --size=100% --stonewall --name=run7 --size=100% --stonewall --name=run8 --size=100% --stonewall --name=run9 --size=100% --stonewall --name=run10 --size=100% --stonewall > ${filename1}.out 2>&1

#Secure Erase
sg_raw -r 1k $ssdpath 48 02 00 00 00 00 00 00 00 00
sleep 300

#Random
fio --minimal --bs=$blocksize --ioengine=libaio --iodepth=32 --direct=1 --randrepeat=0 --norandommap --rw=randwrite --filename=$ssdpath --write_bw_log=${filename2} --write_iops_log=${filename2} --name=run1 --size=100% --stonewall --name=run2 --size=100% --stonewall --name=run3 --size=100% --stonewall --name=run4 --size=100% --stonewall --name=run5 --size=100% --stonewall --name=run6 --size=100% --stonewall --name=run7 --size=100% --stonewall --name=run8 --size=100% --stonewall --name=run9 --size=100% --stonewall --name=run10 --size=100% --stonewall --name=run11 --size=100% --stonewall --name=run12 --size=100% --stonewall --name=run13 --size=100% --stonewall --name=run14 --size=100% --stonewall --name=run15 --size=100% --stonewall --name=run16 --size=100% --stonewall --name=run17 --size=100% --stonewall --name=run18 --size=100% --stonewall --name=run19 --size=100% --stonewall --name=run20 --size=100% --stonewall --name=run21 --size=100% --stonewall --name=run22 --size=100% --stonewall --name=run23 --size=100% --stonewall --name=run24 --size=100% --stonewall --name=run25 --size=100% --stonewall > ${filename2}.out 2>&1
