From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Message-Id: <1064664723.631.47.camel@gaston>
Mime-Version: 1.0
Date: Sat, 27 Sep 2003 14:12:03 +0200
Subject: Breaking MESH on non-pmac
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There will be some work needed if anybody still owns one of
these CHRPs with a MESH SCSI controller.

Basically, I'm switching the driver to macio-based probing
(new driver model).

For MESH to be probed on those CHRPs, one will have to either
hack the driver to add an alternate probe mecanism (ugh !), or
better, add hydra to the list of known macio chips and make the
macio device stuff work on CHRPs, which shouldn't be too difficult
(though it may be weird to have CHRP use pmac_feature.h...)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
