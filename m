Subject: Re: Pegasos 2 support patch ...
From: Adrian Cox <adrian@humboldt.co.uk>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040630155027.GA27912@pegasos>
References: <20040629165029.GA13468@pegasos>
	 <1088587090.28598.3.camel@localhost>  <20040630155027.GA27912@pegasos>
Content-Type: text/plain
Message-Id: <1088611966.28598.52.camel@localhost>
Mime-Version: 1.0
Date: Wed, 30 Jun 2004 17:12:46 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-06-30 at 16:50, Sven Luther wrote:
> static ide_hwif_t *ide_hwif_configure(struct pci_dev *dev,
> 	ide_pci_device_t *d, ide_hwif_t *mate, int port, int irq)
>
> Would it not be better in my case to call ide_hwif_configure with the
> right irq ? Or do i misunderstand what you had in mind ?

It shouldn't make much difference - I only suggested ide_hwif_configure
because it already contains flag checking code.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
