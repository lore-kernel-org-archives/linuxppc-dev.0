Date: Tue, 3 Jul 2001 21:12:54 +0200
To: linuxppc-dev@lists.linuxppc.org
Subject: dmasound_pmac has problems with 16 Bit sound on Pismo
Message-ID: <20010703211254.D311@jupiter.home.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Matthias Grimm <joker@cymes-bs.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I use a Powerbook G3 (Pismo) and the benh-kernel 2.4.5pre6 but I
realized the problem also with earlier 2.4 versions.

If I use the kernel module dmasound_pmac, I wouldn't be able to play
16 Bit sounds. I realized the problem after an update to KDE 2.1 where
the startsound was only noise. After Playing a 16 bit wav sample the
artsd has some problems to return to normal work. I consumes 100% cpu
and timed out after a while. It seems tht no one tells him the osund
is finished.

After that I tried bplay with the KDE wav files and discovered that 8
Bit sound were played well, but 16 bit sounds only create noise of
roundabout the same lenght the sound would have been played.

I gess it could be an endianess problem and I investigated the source
a little but couldn't locate the bug. My know little about the Powerbook
Hardware and the Kernel-drivers so I hope somebody here could help.

With the Kernel 2.2 backport of dmasound, wich I used before I updated
to Kernel 2.4, everything was ok.

At the moment I use the latest alsa-version, which has a awacs-driver
included now. This driver works well, but I would prefer a small well
fitted kernel module instead of a large program package. Nevertheless
alsa is valuable software.

 Matthias

--
____________________________________________________________________
Matthias Grimm                                     joker@cymes-bs.de
----   Planung ist der Ersatz des Zufalls durch den Irrtum     -----

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
