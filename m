Message-ID: <381706D7.FF1D8477@snom.de>
Date: Wed, 27 Oct 1999 16:06:15 +0200
From: Nicolas Pohland <pohland@snom.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC8BUG crashes on Windows 95/98/NT
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi,

I am a PPC newbie, but after checking the FAQ and mailing lists I have 
found a lot of helpful hints but nothing quite addresses my problem.

I am one of the poor sods trying to get a FADS 860T board to work. I
have 
used the cross compiler tools to generate an image of the embedded-2.2.5 
kernel version. 

I had to guess a lot of flags - does someone have a FADS 860T config
file ? 
There seems to be one for everything else ...

I then thought I would just use the MPC8BUG program to program the flash
with
the generated image. 

Is this the correct way of doing this ? Or do I need a Linux tool chain
and
a soldering iron ?

I received my ADI board, read and followed the readme procedure and 
hooked it up to the FADS. But when I try to start the MPC8BUG or
MPC8BUG95 program,
it just crashes under all 3 Windows versions. I have also tried
different IO addresses 
(0x100, 0x200 and 0x300) and used 2 different PCs (133 and 450 Mhz). 

The BIOS of the boards does NOT allow me to set the ISA bus frequency.

The MPC8bug version is 1.6.

Did someone experience also have this problem ?

Or have a viable alternative ?

Any help would be greatly appreciated.

Nicolas Pohland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
