To: linuxppc-dev@lists.linuxppc.org
Subject: Got Pismo firewire working
From: Daniel Berlin <dberlin@redhat.com>
Date: 26 Feb 2001 01:31:31 -0500
Message-ID: <x7u25igdks.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I finally got around to making firewire work on the Powerbook
Pismo.I posted patches to linux1394-devel@lists.sourceforge.net (look
at the  sourceforge mailing list archives).  SBP-2 (what is used for hard
drives/cd-rw's/scanners/etc) doesn't quite work yet. It
detects my 2 firewire hard drives, gets all the info about them right,
and logs into them successfully (it's an sbp-2 thing, for our purposes
it means it's talking to them right, and they are talking back right),
but when it tries to send the scsi commands to read/write, it just times out.
Probably a small endianess issue somewhere.

However, gscanbus and other tools happily show the bus topology
correctly, read/write blocks/quads from the nodes, etc.

If someone has a digital camera or something that doesn't need SBP-2,
it'll probably work.

digital video probably will work too.


--Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
