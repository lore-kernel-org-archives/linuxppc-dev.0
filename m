Message-ID: <395BC95D.48F6B6C@blastoff.com>
Date: Thu, 29 Jun 2000 15:10:37 -0700
From: "Tod E. Kurt" <tod@blastoff.com>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RPX-Lite 823 and ATA disks (PCMCIA), and USB host
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I've been working with Hard Hat Linux and Embedded Planet's RPX-Lite 823
board for a few weeks and would really like to get an ATA disk working
over its PCMCIA port.

I've searched through the archives of this list, tried various
patches/hacks people have come up with but to no avail.  The closest I
got was Jo-Ellen Mathews' treatment of the Magnus Damm PCMCIA patches.

I don't need (or want) true pcmcia-cs services.  No hot-swap or other
PCMCIA niceties are needed. I just want the kernel to recognize the
ATA/IDE disk on boot and map it to device name like 'hda'.  I was hoping
that (like on laptops) just turning on 'IDE/ATA support' in the kernel
would do the trick, but no such easy fix.

I've had no luck from the support channels of either Monta Vista or
Embedded Planet (even though we purchased a subscription from MVista).
So, since I've run through all my options, I figured I'd put out an
impassioned plea to the list. :)

As an aside, I also _really_ need USB host (not peripheral) support for
an 823 board.  Does anyone know of a board that supports this?  EP says
RPX-Lite won't physically have it until September and I need it now.
MVista is planning on releasing a 2.2.14 kernel with USB in a month or
so.

Thanks for any help anyone can give me,
-=tod

--
tod@blastoff.com
Tod E. Kurt
BlastOff!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
