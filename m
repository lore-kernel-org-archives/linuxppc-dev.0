Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <C7FFFEA58B43D311920D0004ACE5333F0F53583A@amer25.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Charles Lockhart'" <lockhart@jeans.ifa.hawaii.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux on the Virtex II Pro?
Date: Thu, 10 Jul 2003 13:48:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Charles,

For our Virtex-II Pro board I used ELDK with minor mods,
mostly for my board.  Current Linux/PPC trees already
include support for 405 as well as the Xilinx ML300 board.
(The Linux/PPC tree I got had slightly stale libgen'ed
code, which I simply replaced with current libgen'ed code
from my XPS project.)  I can send you a patch file on request.

A couple years ago (before ELDK was released) I built
a toolchain from scratch, thinking I'd learn something
in the process.  What I learned was that it's a pain.
My $0.02 is that you're better off using pre-compiled
tool chains (e.g. ELDK).

If I keep mentioning ELDK a lot, it's because:

*	Denx has already done this right.  You can do
	it all over again yourself, but (a) you'd been
	spending time building tool chains, RAM disks,
	etc. which you could have gotten easily, and (b)
	you would be hard pressed to do a better job of
	it than Denx already has.

*	The ELDK build environment comes with nice RPM packaging.

*	The ELDK runtime environment comes with nice init-style
	startup.

*	ELDK supports multiple PPC families (e.g. 4xx, 8xx,
	82xx, ...) as well as ARM.

*	Did I mention it's not expensive ...

Denx Software has done a great service for the embedded Linux
community:  if you read back through this mailing list, you'll
see that many people (including myself) re-invented the wheel,
over and over again.  People would have a bare board, apparently
get a kernel from somewhere, get some GCC source code, and start
hacking.  It was a sad thing.  Now, with ELDK out, you don't have
to re-invent the wheel anymore.  You can spent your time on more
advanced automotive engineering. :)

-----Original Message-----
From: Charles Lockhart [mailto:lockhart@jeans.ifa.hawaii.edu]
Sent: Thursday, July 10, 2003 1:36 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux on the Virtex II Pro?



Hello,

I was looking to see who supports the Virtex2Pro chip for Linux?  In
terms of a tool chain, support, etc?  Has anyone tried building a custom
tool chain for it on their own?  Results?

Thanks,

-Charles Lockhart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
