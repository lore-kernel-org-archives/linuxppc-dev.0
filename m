Message-ID: <40CF6B43.90007@246tNt.com>
Date: Tue, 15 Jun 2004 23:33:55 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: PCI irq mapping for mpc5xxx in denx cvs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I don't see how the PCI irq mapping is done in the denx CVS. I know on
the lite5200 hardware, INTA is connected to IRQ0 and it's the only
connected but I don't see how they are linked in the software. I
though that was the role of the ppc_md.pci_map_irq function but I
don't see any defined ? Is there a default behavior ? Or is it just
luck ;)

Thanks,
    Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
