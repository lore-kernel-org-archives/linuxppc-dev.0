Date: Sun, 13 Feb 2000 17:42:23 -0800 (PST)
From: howarth@bromo.med.uc.edu (Jack Howarth)
Message-Id: <200002140142.RAA49857@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: usb problems in 2.3.45pre2
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Building the rsync'ed linux-pmac-devel tree tonight gave the following
boot errors. This kernel was built taking all the config defaults
except for DE4x5 which should be set as a default for G4s to have
ethernet. The boot gives the following...

usb_control/bulk_msg: timeout
usb_ohci.c: unlink ORB timeout!
usb.c: USB device not accepting new address (error=-110)
INIT: version 2.77 booting
usb.c: USB new device connect, assigned device number 2
page fault in interrupt handler, addr=f2100000

(more dump deleted)

This occurs booting on a Sawtooth G4/450 with an external USB powered hub
and using yaboot 0.5 to boot. Any ideas how to fix this?
       Jack

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
