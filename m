MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ASCII"
Subject: MPC5200Lite and PCI card IRQ
Date: Wed, 2 Jun 2004 11:20:12 +0200
Message-ID: <5A96167EBCEA8440A48790B5419953AE13C43B@gr-lafayette.lacie.com>
From: "Bertrand Baudet" <bbaudet@lacie.com>
To: <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm trying to plug a PCI card on my MPC5200Lite board but I have some
trouble enabling the IRQ.

>From U-Boot, I'm setting the interruption line to IRQ 49. By default,
the interruption line is set to 0.

But when the driver is loaded, it doesn't look like the IRQ is unmasked.
The IRQ# is reported by the driver but when I look at /proc/interrupt,
I have:
           CPU0
49:          0  MPC5xxx Edge


What needs to be done in order to have the IRQ automatically enabled for
the
PCI card installed? (using linux kernel from DENX devel cvs)

Actually, how does it work? When the PCI driver probes the devices, will
it
enable the IRQ set for the PCI device? Or is it the driver for this PCI
card
that needs to enable the IRQ?

I tried to enable the IRQ once the drive reports the IRQ# by calling
enable_irq directly, but I'm getting a "enable_irq(49) unbalanced"




Regards,
Bertrand

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
