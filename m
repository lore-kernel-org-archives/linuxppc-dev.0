Message-Id: <m12kxVj-001SyaC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: Baud rate problems with the EST SBC8260 board
To: dan@netx4.com (Dan Malek), caret@c-side.com
Date: Thu, 27 Apr 2000 19:15:55 -0400 (EDT)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3907A22C.D82EF0D1@embeddededge.com> from "Dan Malek" at Apr 26, 2000 10:13:00 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> From: Dan Malek <dan@netx4.com>

> You probably configured way too much into the kernel.  You have to
> turn of almost everything but the bare essentials.  Just like the
> 8xx, do not configure any serial ports, VTs, or things like that.

I looked for a default EST8260 configuration file in arch/ppc/configs,
but didn't find anything.  Could a est8260_defconfig file be created?
I am look for something that contains a valid MPC8260 Linux configuration
for the EST SBC8260 board?

Dan Malek mentioned that he is using the MontaVista custom ROM (monitor).
Is this monitor available?  If so, under what terms?  Is the GPL'ed?
Does MontaVista offer it for sale, or is it part of the MontaVista
Linux subscription plan?

> How could I possibly use the VxWorks monitor in any product?

EST offers the VxWorks monitor for $1500.  There are no royalties,
and the source code is provided except for the miiLib and motFccEnd files.
The VxWorks monitor is able to boot off the network, so it is possible
to pull down a Linux image and load it.

Other than the MontaVista custom ROM and the VxWorks monitor, do you
know of any other options for a MPC8260 monitor?  At a bare minimum
we need to:

- Initialize the EST SBC8260 hardware enough to run Linux
- Automatically transfer control to a configurable address.

Options I have looked at:

- 8xxrom, http://www.solutions4linux.de/powerpc.html

      This has promise, but it needs to be worked for the MPC8260

- Linux Boot Project, http://ppcboot.sourceforge.net/

      The 8xxrom effort is being reborn, but the web site is only a
      place holder.

- Neil Russell <caret@c-side.com> mentioned in
  http://lists.linuxppc.org/cgi-bin/wilma/wilma_hiliter/linuxppc-embedded/199911/msg00089.html
  that he is working on a PPC loader.  I believe that Neil Russell
  has something that runs on a EST SBC8260 board, but it isn't available
  under a public license.  I wonder if this changed since limon-1.1 dated
  3/21/2000?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
