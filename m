Message-ID: <3F95161F.1080206@mixed-mode.de>
Date: Tue, 21 Oct 2003 13:18:55 +0200
From: Tamas Bara <tba@mixed-mode.de>
MIME-Version: 1.0
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: PCI on MPC8265
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I´m running Linux 2.4.4 on a TQM8260 board with
an MPC8265 on it and an Ethernet controller on
the PCI Bus.

When Linux scans the PCI Bus it detects the
controller multiple times. I could change the for
loop to devfn < 9 since I only got the internal
host bridge and the controller on the bus:

/* Go find them, Rover! */
for (devfn = 0; devfn < 0x100; devfn += 8) {
	dev0.devfn = devfn;
	pci_scan_slot(&dev0);
}

This works, but I don´t want to change the kernel.
So I´m looking for a different solution.

How does the kernel know that it already detected
a device before?

Thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
