Message-Id: <200108231929.VAA00718@piglet.grunz.lu>
Date: Thu, 23 Aug 2001 21:29:16 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.4.9-benh0 problems and kudos
To: bob@kunk.jriver.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010823164256.8751.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  23 Aug, this message from Robert E Brose II echoed through cyberspace:
> On the positive side it looks like the 7500 chaos PCI bus fixes
> have been incorporated as well as the planb fixes and the
> controlfb enhancements.

Hooray ;-)

> I've run into a couple of small problems however....
>
> planb.c has a problem in 2074.
> pb->lock = 0;

Yep.

> pb->lock is defined as a semaphore so this gives the following
> compiler error...
>
> planb.c: In function `init_planb':
> planb.c:2074: incompatible types in assignment

Just remove that line 2074. I've sent a patch off to BenH; it should
appear in his tree RSN.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
