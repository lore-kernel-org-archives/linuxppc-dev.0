Date: Fri, 09 Feb 2001 19:06:16 +0000
Subject: DMASOUND 2.4.2 Patches. (replaces dmasound ed 21)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org, linux-m68k@lists.linux-m68k.org,
	linux-apus-devel@lists.sourceforge.net
Cc: benh@kernel.crashing.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010209190546.842D12EFFD@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello sound testers et. al.

replacement for dmasound ed 21 (which won't work against recent kernels).

======

The following set of patches has been submitted to Paulus for (hopefully)
inclusion in 2.4.2.

They include (most) of the stuff that was hacked in dmasound ed21 - but now
in a non-hacked version and against an up-to-date kernel version [BK
linuxppc_2_4 2.4.2pre1].

The current BK kernel also includes preliminary iBook DACA support (merged
from _2_5 by Paulus) but only sound out (no mixer capability yet).  I've
tried to protect iBook against someone trying read() or other stuff... we
shall see.

... and there are people working on the mixer ...

==========

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.2p1-dmasound-patches/

... dmasnd-2.4.2p1ix.diff.bz2 ...  + discussion.txt

ix refers to the patch number and the discussion text says what each one
does.  Or you can apply all of them (xxx_all.diff) and just try it...

Kernel Gurus:
=============

M68K & APUS - please read the discussion text file if you have an interest
in dmasound (especially if you are able to provide any input on the
individual low-level drivers).  Note I am subscribed to m68k & linuxppc but
not APUS - so please copy mail to me from the latter list.

I have tried very hard not to affect (other than fixing bugs + adding
facilities I can see "by eye") m68k & APUS - but I can't build or test... so
any testing would be appreciated.

Sound Testers:
==============

If you just want to test it (and I believe it really *is* stable in record &
under heavy CPU load)...

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.2p1-dmasound-patches/dm
asnd-2.4.2p1_all.diff.bz2

It is missing some of the "glitzy" bits that were in dmasound ed21 - sorry -
that's a subsequent patch (when I get time - I'll merge it).

in particular, there are no additional LE soft swapping functions.  However,
I believe that the machine capabilities are now reported correctly via the
SNDCTL_DSP_XXX ioctls... and therefore if an app doesn't work with Pismo -
it (the app) is broken... and you should bang on the app's maintainer.

there's a new version of the stest program (which fixes an inability on my
part to RTFM ;-) at :

ftp://ftp.penguinppc.org/users/iain/sound_test/sound_test.tgz

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
