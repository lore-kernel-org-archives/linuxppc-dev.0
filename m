Message-ID: <3755DFA8.B871A07E@crosswinds.net>
Date: Wed, 02 Jun 1999 21:51:37 -0400
From: Jeremy Welling <jwelling@crosswinds.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Help!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've got a G3 minitower.  I can't get it linux to acknowledge the ultra
scsi drive.  I tried to bypass the builtin scsi by plugging it into the
pci scsi card.  No help.  I've also tried kernels 2.2.1 thru 2.2.7.  I
started by partitioning the internal drive with the correct partitions.
When boot linux through bootX, I go into the redhat installer and it
can't find the disk.  I drop out to the redhat messages and it says
"/proc/scsi/scsi: Attached devices: none".  The kernel messages note
detecting scsi0 :  MESH  scsi : 1 host.  and no other controllers.  If
anyone has any input, it would be greatly appreciated.

Thanks!
Jeremy Welling

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
