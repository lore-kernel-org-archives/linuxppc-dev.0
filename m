Message-Id: <4.2.0.58.20001125140721.009f2220@shell13.ba.best.com>
Date: Sat, 25 Nov 2000 14:23:38 -0800
To: linuxppc-embedded@lists.linuxppc.org
From: Ron Avisa <ravisa@base2software.com>
Subject: strange lockup on PPC860T 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


With gracious help of Wolfgang Denk (providing a ramdisk.image) was able to
bring up a console along with networking etc.
However I'm seeing some strange lockup happening at 0xC00026a4 which
corresponds to do_signal_ret() in head.S.

micro is a power pc 860T
I'm using a redhat edk 2.2.13 kernel.
My board from hell is custom, so I've been making as few changes as
possible to the mbx build version of the kernel.
And I'm booting using ppcboot. Bdinfo on ppcboot and mbx build match.
Aside from I/O changes biggest changes have been disabling of external ints
and ioremapping to corresponding to this board.


currently shifting environment to hardhat for newer kernel.

Any suggestions on the above problem?

Thanks,

Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
