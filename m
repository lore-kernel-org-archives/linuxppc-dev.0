Message-Id: <200007242244.XAA21388@hyperion.valhalla.net>
Date: Mon, 24 Jul 2000 23:44:04 +0100
Subject: [ANN] IRQ Latency tool 0.1.3 release.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: jsun@mvista.com
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi list...

Well, here is a tool that should allow identification of rogue IRQ blocks
(ints held off for a long time).

This is important to those of us trying to do audio on LinuxPPC - it would
be a great shame if we couldn't succeed where MacOS 9 already performs...

Many thanks to Jun Sun for the code that was the inspiration (and basis) of
this...

It is well-tested on my system but needs other input...

It needs some development input before it's going to work on Gemini/APUS/8xx
- because the code is too hairy to do without a system to test on (well for
me it is anyway :-)

Take a look, have a go, tell me what happens....

http://www.drfruitcake.com/linux/irq_blk.html

BTW: on my system ll_rw_blk.c gets up to 750 us quite often when the system
is loaded... this **IS** a potential problem for audio use.

log entry : 3  (16  history entries)
        Peak Block Time  :        430.0 us  (    7185) [ OK ]
        startFilename    : ll_rw_blk.c                    Line : 167
        endFileName      : ll_rw_blk.c                    Line : 179

I still haven't found the "hard-block" that is effecting the overall audio
latency performance... ah well, back to the drawing board...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
