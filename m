Message-Id: <199908072033.NAA10643@soda.CSUA.Berkeley.EDU>
To: linuxppc-dev@lists.linuxppc.org
Subject: Working SMP Kernel Source for PMac
Date: Sat, 07 Aug 1999 13:33:03 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

I am trying to build an SMP kernel for my system. I am running
LinuxPPC R4 on a PMac 7600 with a nPower 400 (2 604e 200's). I would
like to know where to get a complete kernel source tar-ball that
supports SMP on PMac's.

So far I have tried the stock 2.2.6 and 2.2.7 sources from kernel.org
and the 2.2.10-pmac sources from sunsite.anu.edu.au. I have not been
able to build a bootable SMP kernel from any of these source
tarballs. The kernels built from these images crashes during boot in
"swapper".

The process I am using for building the kernel is:

# cd /usr/src/linux 
# make mrproper ; make pmac_config ; make menuconfig ; 
# make dep && make clean && make vmlinux

If there is something additional that I need to do please let me know.

I am curretly using a SMP 2.2.7 kernel from borg.mit.edu, but it
appears that borg.mit.edu only has compiled kernel images, not source
tar-balls. If anyone has the sources for this kernel, I would
appreciate a pointer.

The only SMP kernel I have been able to built and boot sucessfully was
2.2.0-pre6. I don't want to go back to this version since the DEC
2x14x ethernet support was flaky.

Thanks,

----ranga <ranga@soda.berkeley.edu>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
