Date: Sun, 19 Mar 2000 14:44:05 -0800 (PST)
From: howarth@bromo.med.uc.edu (Jack Howarth)
Message-Id: <200003192244.OAA22419@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: new XFree86 4.0 test rpms
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


    I have built new -0.2d XFree86 v4.0 test rpms and placed them
in my public_html on entropy.crashing.org. These can be accessed
from http://entropy.crashing.org/~howarth/. The new rpms correct
a flaw in redhat's -0.2 spec which misplaced support files. The
new rpms also eliminate the driver packages that currently don't
work properly. A new XF86Config is in the top level directory
which was generated from XFree86 -configure and is more correct
than the previous one. Xkb is still disabled as there is an unresolved
problem on usb keyboards.
                          Jack Howarth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
