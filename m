Message-Id: <200109271310.JAA20256@missioncriticallinux.com>
From: mod+linuxppc-embedded@MissionCriticalLinux.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Adding 'bus_offset' to pci_controller 
In-Reply-To: Your message of "Wed, 26 Sep 2001 16:29:00 PDT."
             <3BB264BC.8E7291FE@mvista.com>
Date: Thu, 27 Sep 2001 09:10:08 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm just catching up with this thread and I'm
not sure which problem it is that we're trying
to solve here.  Isn't it true that the various
pci_ops routines are passed a pci_dev from which
they can extract pci_dev->pci_bus->number and
decide which bus is meant from that?  Or does
that constitute a namespace (or number-space)
collision?  Aha - yes it might - each "node" in
a PCI bus "tree" has its own bus number, right?
So pci_dev->pci_bus->number is only intended to
be meaningful within a given tree and each tree
is (should be) its own domain...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
