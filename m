Date: Sun, 16 May 1999 13:39:23 -0500
From: strimmer <strimmer@cs.oberlin.edu>
Subject: About Darwin Install, and Sound in linuxppc
To: linuxppc-dev@lists.linuxppc.org
Message-id: <0FBU00IR56DKQ7@oberlin.edu>
MIME-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I know it is off topic for the list, but the darwin list is not helping 
at all.  I finially have an almost working pre-R5.  Yeah!!  My problem 
though is the Darwin install says it needs a 1GB drive, but it will not 
install on my 1.2GB drive.  I have about 1.4 GB free in a partition on 
another drive, but the Darwin installer states it must delete all the 
data on the drive.  Can anyone help me out?  Possibly package the 
installer smaller, or post some image files I can setup using my linuxppc 
install.  Thanks a lot.
     -Scott
=;)
P.S. I'm new to kernel compiling, and I can't get an 2.2.6-15apmac kernel 
to compile that gives me sound.  I type make pmac_config  make menuconfig 
 (All the Mac dma sound options are on), make dep, make image, make 
modules, make modules_install.  Copy the vmlinux file generated into my 
system folder and restart.  

Could someone either send me instructions on where I went wrong, or 
possibly a working kernel conf file?  I have a beige G3 MT/266.  I'm 
running off of my external SCSI drive.  17" Apple 720 Monitor.  64 MB 
RAM.  Thanks again for all of your help.  

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
