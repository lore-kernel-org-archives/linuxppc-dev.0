Date: Thu, 16 Mar 2000 19:47:41 -0800 (PST)
From: howarth@bromo.med.uc.edu (Jack Howarth)
Message-Id: <200003170347.TAA18432@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: XFree86 4.0 test rpms available
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
   I have built a set of test rpms for XFree86 v4.0 based on the -0.2
rpms released from RedHat. These rpms have been tweaked to build on
linuxppc (you will need to use the 2.2.x kernel headers due to a flaw
in the 2.3.x asm/types.h header on ppc). The rpms and srpm are available
on http://entropy.crashing.org/~howarth/XFree86_v4.0/. The r128 driver
works well and a template XF86Config is available in the same directory.
This XF86Config has been tested on a G4/450 (AGP) with Linux 2.2.15pre14
from Paul's linux-pmac-stable tree.
                                      Jack

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
