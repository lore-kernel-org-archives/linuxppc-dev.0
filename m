Date: Wed, 12 Dec 2001 16:58:19 -0500
From: Kent Borg <kentborg@borg.org>
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Compile Penguin PPC for x386?
Message-ID: <20011212165819.D1790@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is the i386 arch vaguely up to date in the PPC tree?  Does it work?

I mean, if I want to debug some driver that doesn't need actual
hardware (maybe dummy out actual HW banging), can I swap over to
building an i386 kernel?  It would be nice to be using the same
kernel.

If I can do that, how?  In Makefile I changed "ARCH" to i386, changed
"CROSS_COMPILE" to be nothing, did a "make mrproper", copied in a
.config from my Red Hat install, defaulted everything asked by "make
oldconfig", did "make dep", and "make bzImage".

But then it chokes on some problem in include/linux/highmem.h (48:
parse error before `0').

Should this work?


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
