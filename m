Message-ID: <384D993C.46D0D76F@currantbun.com>
Date: Tue, 07 Dec 1999 23:33:16 +0000
From: "Jens Ch. Restemeier" <jrestemeier@currantbun.com>
Reply-To: jrestemeier@currantbun.com
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Open Sourced Glide on Linux PPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

maybe you already know that Glide is Open Sourced, so I gave it a shot
compiling it on Linux/PPC, before disassembling my PC to get out the
VooDoo 1 and move it into the PMac.

There are some obvious problems, like -m486 compiler switches, or an
undefined P6FENCE macro. But now I'm stuck: in fxlinux.c are references
to inb() & Co. , and they expand to something using isa_io_base, which
is undefined on my machine. Even funnier because I don't have ISA slots
at all (PMac). 
I'm using a 2.2.3 kernel, and it's quite possible that I messed up some
headers while building other stuff.

Questions:
- Has anybody had any success compiling Glide/Linux/PPC/VooDoo1 ?
- Is this isa_io_base thingy changed in newer kernels, or did I just mix
up my configuration ? I don't really like downloading kernels/patches
through my slow connections, so I'd like to be sure...

Thanks,
Jens

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
