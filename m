Message-ID: <3922CB9E.873738B6@ccrl.mot.com>
Date: Wed, 17 May 2000 11:41:02 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: more on e2fsck
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


when I run mke2fs /dev/sda2 it creates a file system just fine. Then I
fun e2fsck on the newly created filesystem and it reports that its
clean.
next I mount the new filesystem and the kernel reports the following:

EXT2-fs error (device sd(8,2)): ext2_check_blocks_bitmap: Wrong free
blocks count for group 18, stored = 32260 counted = 32256
EXT2-fs error (device sd(8,2)): ext2_check_blocks_bitmap: Wrong free
blocks count in super block, stored = 2198781 counted = 2198777

then I un-mount it and run e2fsck again and I get the message that
I reported
before - filesystem has errors and e2fsck seg faults

is there possibly some disparity between the kernel's ext2 fs code and
what
mke2fs and e2fsck are doing? if anyone has any further thoughts on this
I would appreciate it.

Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
