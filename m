Date: Tue, 16 Mar 1999 22:04:41 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Linux-2.2.3 MTX SMP patches
Message-ID: <Pine.LNX.4.04.9903162157200.18016-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For those of you with dual CPU Motorola embedded boards, I have just
updated my patches for SMP and some other stuff.

See

ftp://ftp.microux.com/pub/linux/rework+SMP-2.2.3.patch.gz or 
ftp://ppc.kernel.org/pub/linux/patches/mtx-smp/rework+SMP-2.2.3.patch.gz

This works on my MTX board, but still has some crashing problems under
heavy load. (3 or 4 large compiles will do it for me.)

The next time I update this, I'm hoping that bitkeeper will be available
and Cort will have integrated some of Corey Minyards (and these) patches,
makeing things much nicer.

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
