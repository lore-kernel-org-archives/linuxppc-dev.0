Message-ID: <37B5E009.FBA8C036@talknet.de>
Date: Sat, 14 Aug 1999 23:30:50 +0200
From: Alois Fertl <alois_fertl@TalkNet.de>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>,
        VALETTE Eric <valette@crf.canon.fr>
CC: LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: IDE on Motorola Hardware
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort, Eric

Some time ago I issued a patch to fix IDE related problems on Motorola
hardware. This patch was not specific enough and broke the IDE support
on IBM. Here is a revised version which hopefully will not break other
systems.

For me this patch works on a RiscPC with the 87303 and on a system
with the WINBOND chip for both disks and CD drives.

Note:
IDE disks may appear to work correctly. It is possible to fdisk and
to generate filesystems. If such a disk is than connected to a intel
system, it will not be recognized due to the byte swapping.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
