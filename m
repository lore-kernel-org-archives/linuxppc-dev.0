Date: Thu, 13 May 1999 17:44:40 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: compile troubles in 2.2.8
In-Reply-To: <Pine.LNX.4.04.9905131041210.12269-100000@fachschaft.cup.uni-muenchen.de>
Message-ID: <Pine.LNX.4.05.9905131743580.651-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 May 1999, Oliver Neukum wrote:

> PS: Is there really a PPC-machine with an isa-bus?

CHRP.  PReP too (maybe)

> diff -u --recursive linux/arch/ppc/kernel/pmac_setup.c /usr/src/linux/arch/ppc/kernel/pmac_setup.c
> --- linux/arch/ppc/kernel/pmac_setup.c	Thu May 13 10:02:13 1999
> +++ /usr/src/linux/arch/ppc/kernel/pmac_setup.c	Thu May 13 09:29:26 1999

Adding #include <asm/dma.h> fixes this as well, properly.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
