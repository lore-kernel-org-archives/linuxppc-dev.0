Message-ID: <3A3E9A83.8AB090C8@mvista.com>
Date: Mon, 18 Dec 2000 18:15:15 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Huy Vu <huy.vu@ipoptical.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: EST8260 Boot Problem
References: <F7B644B6C3C7D41191F700B0D06888190AAAE8@optic3.ipoptical.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Huy Vu wrote:

> !HALT! - [msg90007]* Exception taken; PC = 0x00900000  Software Emulation

All I know is this is the start address of the image.  At least it got
that much right.  I have never used this monitor.

> P.S. What's HHL talking about when they say "estflash" or "estsimm" and
> "rmon" is included in the CDK.. I installed all packages and I have yet to
> find it...

It is a small rom monitor I wrote along with some programs you can
run from Linux to program the simm and flash prom on the board.  They
have been nothing but headaches, and I think MontaVista consultants
have helped a few customers with the software.  It is best if this
software is just forgotten.  The Wind/EST tools don't want to accomodate
anything but their formats of data in the flash and VxWorks, and trying
to mix these tools with any other software is very frustrating.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
