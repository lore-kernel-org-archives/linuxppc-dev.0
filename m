Message-Id: <199905042220.PAA17423@soda.CSUA.Berkeley.EDU>
To: linuxppc-dev@lists.linuxppc.org
Subject: USB under LinuxPPC
Date: Tue, 04 May 1999 15:20:37 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

I have been trying to compile USB support into the 2.2.5 kernel on
LinuxPPC using the uusb driver.

On my LinuxPPC machine I keep getting errors that the struct s_snode
has no element named lock. I checked in usb-slist.h and this struct's
definition does not have an element named lock, nevertheless it is
referenced throughout the usb driver code. 

If anyone has been able to comple the uusb driver on LinuxPPC, I would
appreciate some pointers.  Also if there is a version of the usb
drivers that compiles with kernel 2.2.0pre6, I would like to use it,
since the SMP support on 2.2.1+ has been quite buggy for me.

Thanks,


----ranga <ranga@soda.berkeley.edu>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
