Message-ID: <3842C0D1.38C1D2FD@drea.dnd.ca>
Date: Mon, 29 Nov 1999 13:07:13 -0500
From: Gavin L Hemphill <hemphill@drea.dnd.ca>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: problem with the latest linux-pmac-stable from linuxcare.com.au
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just rsync'd the linux-pmac-stable tree this morning, and found that
it no longer builds.  There is a undefined reference to
"buffer_lowprio".  Now this function used to be defined in
"include/linux/fs.h"  but it appears to have been cleared out of there
(along with a bunch of other stuff refering to buffer). It appears to
still be used by "drivers/block/ll_rw_blk.c" and md.c and raid*.c.  Is
there any problem adding the functions back into fs.h, or is there a
better way to resolve the undefined references?
        G++

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
