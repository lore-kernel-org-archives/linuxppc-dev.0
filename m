Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp2.wanadoo.fr (smtp2.wanadoo.fr [193.252.22.29])
	by ozlabs.org (Postfix) with ESMTP id D281F685E6
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 08:24:35 +1100 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0202.wanadoo.fr (SMTP Server) with ESMTP id 36C901C001FB
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 22:24:33 +0100 (CET)
Date: Mon, 31 Oct 2005 22:21:28 +0100
From: Sven Luther <sl@bplan-gmbh.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20051031212128.GA32116@localhost.localdomain>
References: <20051025075159.GA10316@localhost.localdomain>
	<17251.265.196352.234376@cargo.ozlabs.ibm.com>
	<20051031190524.GE5055@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051031190524.GE5055@mag.az.mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, Sven Luther <sl@bplan-gmbh.de>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_pcidev - implements
	hotplug for the marvell gige functionality by probing the
	northbridge pci id.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 31, 2005 at 12:05:24PM -0700, Mark A. Greer wrote:
> On Sat, Oct 29, 2005 at 02:56:41PM +1000, Paul Mackerras wrote:
> > Sven Luther writes:
> > 
> > > +static struct pci_device_id pci_marvell_mv64360[] = {
> > > +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },
> > 
> > Are there other devices in this northbridge whose drivers might also
> > want to bind to this PCI id?
> > 
> > What other devices does this northbridge contain?
> 
> It does have a PIC, DMA engine, and SRAM that Sven mentioned but there
> are also a serial controller (MPSC), an i2c controller, and a watchdog
> timer.  I would guess that the MPSC and i2c drivers, at least, should
> use MODULE_DEVICE_TABLE.  If you agree, I'll add it to the list.

Yeah, forgot those, we don't use them on the pegasos though. 

Friendly,

Sven Luther
