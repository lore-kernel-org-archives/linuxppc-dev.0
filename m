MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14119.28843.240109.664411@onyx.nowhere.net>
Date: Wed, 28 Apr 1999 22:33:47 +0200 (CEST)
From: Ralf Weidemann <ralfw@gatekeeper.informatik.fh-dortmund.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: mesh problem ?
Reply-To: Ralf Weidemann <ralfw@gatekeeper.informatik.fh-dortmund.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have today installed a new drive, so I'm not sure if it is
a problem with the drive itself or maybe a mesh problem. I
got several system lockups until yet and the below I got while
I tried to fsck the disk after an ealier crash. After rebooting
I tried again fsck the drive and all went fine. 

Hmm, should I get a new drive or could it be a mesh problem ?
This is a wide scsi drive with an adapter if it somehow matter.

Ralf


Vendor: IBM      Model: DDRS-39130W      Rev: S97B
Type:   Direct-Access                    ANSI SCSI revision: 02

Apr 28 21:03:32 onyx kernel: scsi : aborting command due to timeout : pid 83500, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 7e 94 5b 00 00 10 00 
Apr 28 21:03:32 onyx kernel: mesh_abort(c7fc2e00)
Apr 28 21:03:32 onyx kernel: mesh: state at c7fd1878, regs at cd01d000, dma at cd01fa00
Apr 28 21:03:32 onyx kernel:     ct=   0 seq= c bs=   0 fc= 0 exc= 0 err= 0 im= 7 int= 0 sp=f0
Apr 28 21:03:32 onyx kernel:     dma stat=e0 cmdptr=7fbe010
Apr 28 21:03:32 onyx kernel:     phase=0 msgphase=0 conn_tgt=1 data_ptr=1024
Apr 28 21:03:32 onyx kernel:     dma_st=0 dma_ct=0 n_msgout=0
Apr 28 21:03:32 onyx kernel:     target 0: req=c7fc2e00 goes_out=0 saved_ptr=0
Apr 28 21:08:48 onyx syslogd 1.3-3: restart.
Apr 28 21:08:49 onyx kernel: klogd 1.3-3, log source = /proc/kmsg started.
Apr 28 21:08:50 onyx kernel: Loaded 13413 symbols from /boot/System.map.
Apr 28 21:08:50 onyx kernel: Symbols match kernel version 2.2.6.
Apr 28 21:08:50 onyx kernel: No module symbols loaded.
Apr 28 21:08:50 onyx kernel: device tree used 16108 bytes
Apr 28 21:08:50 onyx kernel: Total memory = 128MB; using 512kB for hash table (at c0200000)
Apr 28 21:08:50 onyx kernel: Linux version 2.2.6 (root@onyx) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #7 Fri Apr 23 00:42:57 CEST 1999


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
