Message-ID: <3B7B4A86.4B10CC66@cdotb.ernet.in>
Date: Thu, 16 Aug 2001 09:52:30 +0530
From: "N.Suresh" <nsuresh@cdotb.ernet.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, linuxppc@lists.linuxppc.org
Subject: RedHat edk linux on mbx board
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI,
    I am trying edk 1.0 on MBX 860 board. My host is redhat 6.2
    linux.

   I was able to compile the kernel and get zImage and httpd demo
  program using source navigator.

  After that when i boot up the MBX to get the zImage , i am not able
  boot the kernel itself.. It shows the error message:

 <cut>
 EPPC-Bug>pl 20 0
 Network Booting from: MPC860, Controller 20, Device 0
 Loading: Operating System

 Client IP Address      = 192.168.254.15
 Server IP Address      = 192.168.254.3
 Gateway IP Address     = 0.0.0.0
 Subnet IP Address Mask = 255.255.255.0
 Boot File Name         = /tftpboot/192.168.254.15/zImage
 Argument File Name     =

 Bytes Received =&471790, Bytes Loaded =&405938
 Bytes/Second   =&235895, Elapsed Time =2 Second(s)
 loaded at:     00210000 00204AA4
 relocated to:  00100000 000F4AA4
 board data at: 00FF4558 00FF4580
 relocated to:  00200100 00200128
 zimage at:     00216000 00271FD8
 avail ram:     00272000 01000000

 Linux/PPC load:
 Uncompressing Linux...done.
 Now booting the kernel
 </cut>

     And the target hangs..
     Anybody has any idea what's happening..

     thanx in advane.
     bye

 --
!============================================================================!
= Suresh N., Research Engineer, C-DoT, Bangalore.                            =
= Call me at : OFF: 2383951(Dir) / 2263399 (268)                             =
=              RES: 3334248  MOBILE: 98441 77782                             =
= Alternate email :  nsur_mys@email.com                                      =
= QOT: For fast-acting relief, try slowing down.
!============================================================================!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
