Subject: Re: [PATCH 2.6] fix pci_update_resource() / IORESOURCE_UNSET on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: prism54-devel@prism54.org,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031220130907.GA15552@obroa-skai.de.gnumonks.org>
References: <20031220130907.GA15552@obroa-skai.de.gnumonks.org>
Content-Type: text/plain
Message-Id: <1072237945.737.36.camel@gaston>
Mime-Version: 1.0
Date: Wed, 24 Dec 2003 14:52:25 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-12-21 at 00:09, Harald Welte wrote:
> Hi!
>
> The prism54 (http://prism54.org) driver for my cardbus adapter works
> with 2.4.x, but not 2.6.x on a Titanium G4 Powerbook IV.
>
> On 2.6.x the error message was
> PCI:0001:02:00.0 Resource 0 [00000000-00001fff] is unassigned
>
> After investigating differences in the PCI code of 2.4.x and 2.6.x, i
> noticed that 2.4.x/arc/ppc/kernel/pci.c:pcibios_update_resource()
> contained a couple of lines that unset the IORESOURCE_UNSET bitflag.
>
> .../...

Can you submit to lkml ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
