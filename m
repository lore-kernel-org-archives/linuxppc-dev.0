From: David MAZUR <dmazur180@dpeurope.be>
Message-ID: <13816.217.136.171.4.1071245588.squirrel@webmail.dpeurope.be>
Date: Fri, 12 Dec 2003 17:13:08 +0100 (CET)
Subject: PCI display adapter / MPC5200
To: <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am using the latest CVS version from the Denx LinuxPPC_2_4_devel tree.
Apparently the PCI bridge on the MPC5200 should be fully supported in the
linux kernel, but I am having varying results with PCI adapters on the
Lite5200 eval board.
A Belkin USB-4 port adapter (PCI 3.3V/5V) is successfully detected and can
be accessed.
However, an ATI Radeon 7000 PCI (also 3.3V/5V) adapter is simply not
detected (when doing a scan through PCI config space).

As I would like to be able to have graphical output on the Lite5200, I
would like to know if anybody has been successful in using a PCI display
adapter on the Lite5200 with a recent LinuxPPC_2_4_devel tree ?

Thanks.

Best Regards,
David Mazur


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
