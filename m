Date: Wed, 11 Apr 2001 15:55:40 -0400 (EDT)
From: Jack Howarth <howarth@bromo.med.uc.edu>
Message-Id: <200104111955.PAA57515@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: boot failures after memory upgrade
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
    Does anyone have any experience with Linux 2.4.x on ppc using
Powermac G3/G4's with 512 Mb or ram or more? I was running the current
Bitkeeper linuxppc_2_4 (Linux 2.4.4pre1) with 256 M of ram and 255 M
of swap and had no problems booting. Last night I upgraded my machine
to 512 M of ram and tried both 255 M and 1.2 G of swap. The problem
I am seeing is that randomly the machine will hang on the swap
activation (the second call to swapon in the rc.sysinit). The first
swapon never hangs but uses -e to ignore unavailable devices. The
second call to swapon doesn't use this flag.
   I am wondering if I need to use CONFIG_HIGHMEM or such when I
build a kernel. Thanks in advance for any suggestions on solving this
problem.
                  Jack


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
