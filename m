Date: Wed, 14 Mar 2001 21:28:48 +0000
Subject: dmasound binaries 2.4.3p3 (up to patch 6)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Cc: danboid@yahoo.co.uk
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010314212844.D97F8DBA5B@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

for a few who requested it I've posted my build of 2.4.3p3 kernel:

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.3p3-dmasound/vml-2.4.3p
3-s6

modules (dmasound_pmac up to patch 6):
ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.3p3-dmasound/mod-2.4.3p
3-s6.tgz

and System.map:

ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.3p3-dmasound/sym-2.4.3p
3-s6.bz2

alongside the actual patches.

For those waiting for patch 7 (which fixes a few bugs for xine, and Power
Computing machines + puts back most of the ed21 stuff)... it's going to be a
few more days (some of the fixes are more difficult than I thought...).

The kernel includes USB, new input layer, pmac IDE & the sym scsi - but not
the a7xxx driver (which wouldn't build for me)... there are no warranties
that it will boot your machine (but it does happily on mine ;-))

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
