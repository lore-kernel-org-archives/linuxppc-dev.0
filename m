From: gopi@india.tejasnetworks.com
Date: Wed, 30 Jan 2002 12:14:13 +0000 (GMT)
To: linuxppc-embedded@lists.linuxppc.org
Cc: cort@cs.nmt.edu
Subject: kernel hang when machine_restart called from isr
Message-ID: <Pine.LNX.4.21.0201301141250.25516-100000@tn100build.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi..

  linux: hardhat linux for powerpc(linux 2.2.14)

  We are calling machine_restart(which call m8xx_gorom) from an isr,
but the kernel hangs after coming to some stage on the restart.

If we call the same machine_restart from a simple ioctl, it works.

  Is there any limitation on the usage of machine_restart?  Does it
assume something which is not true when called from an ISR?

thanx
gopi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
