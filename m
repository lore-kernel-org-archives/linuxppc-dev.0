Date: Sun, 10 Jan 1999 16:24:13 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Corey Minyard <minyard@acm.org>, Gabriel Paubert <paubert@iram.es>,
        Matt Porter <mmporter@home.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: arch/ppc/kernel restructure + MVME/MTX OpenPIC support
Message-ID: <Pine.LNX.4.04.9901101614300.926-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have just finished some early testing of this.

The patch is available on
ftp://ftp.microux.com/pub/linux/linuxppc-rework-troy.patch.gz

Here's what I put in the REAME:

This is my set of integrated patches to the Linux kernel, which are based on
Corey Minyard's linuxppc-rework3.diff patches, along with Gabriel Paubert's
Preploader (which I have integrated into arch/ppc/preploader) and Raven MPIC
support for Motorola MTX/MVME boards.

This works on my MTX board, but only with CONFIG_PREPLOADER (the preploader
has a config option ;) ) because the raven needs to have it's PCI memory
space remapped or it isn't accessible.

Pmac should work, along with APUS. I think I may have broken MBX support..
Can someone check this out and fix this?

These patches were made from my local CVS archive agains 2.2.0-pre6.
Please let me know if you have any additions, etc. 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
