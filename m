Date: Sun, 24 Jan 1999 17:03:58 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: alpha MTX/MVME SMP patches available
Message-ID: <Pine.LNX.4.04.9901241656530.17601-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


see ftp://ftp.microux.com/pub/linux/rework+SMP-pre9.patch.gz

from the README.rework+SMP file:

This set of patches is the earlier rework patches, updated to
linux-2.2.0-pre9, with the addition of MTX/MVME SMP support

Components:

 * Initial ALPHA support for SMP on Motorola MTX and MVME46xx dual CPU boards.
   Both processors run on my MTX. The changes shouldn't affect anyone running
   a pmac or non-SMP prep. If you can try this, please report success or
   failure to me. If you expect to be making lots of changes to this, get
   ahold of me (troy@microux.com) about getting access to the CVS archive
   I'm using.

   Only one proc is receiving interupts currently, and IPI is not supported.
   the kswapd portion of mm/vmscan.c had to be backported to pre4, otherwise
   kswapd would crash when SCSI was being initialized.

 * Corey Minyard's machdep rework

 * Gabriel Paubert's OpenPIC support

 * Gabriel Paubert's Preploader (in the arch/ppc/prepboot dir)
   This is required for MTX SMP. (starting the second CPU depends on residual
   data currently) 


--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
