Message-Id: <200109241907.OAA30214@lists.linuxppc.org>
From: "Boerner, Brian" <bmb@pirus.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MMU: address translation for 0x00001100 failed
Date: Mon, 24 Sep 2001 15:11:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I get the above message when attempting to step through the
time_init function on a walnut using the BDI2000.

I set a hard break at 0x0 at the bdi prompt and the continue.
ppcboot passes control to linux at 0x0 and the bdi stops the
execution. I then change the break type to soft but will try hard.
I can then connect via gdb and set a break at start_kernel.
Everything is working fine. I can see the start_kernel code and gdb
appears to be happy with respect to setting other breaks. Once it
stops in time_init and then branches off to ppc4xx_time_init I get
the following messages on my BDI console:
*** MMU: address translation for 0x00001100 failed
*** MMU: address translation for 0x00001100 failed
*** MMU: address translation for 0x00001100 failed
*** MMU: address translation for 0x00001100 failed

continuing from here pretty much hangs gdb in the emacs window
and I've taken some kind of exception because if you stop it
with the bdi console I can see I'm sitting in panic(). I'm
guessing but it's probably either a machine check or a program.

Has anyone seen this message before? If so, what was done to resolve
them? Thanks in advance for any assistance.

-bmb

Brian Boerner
Member of Technical Staff
Pirus Networks

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
