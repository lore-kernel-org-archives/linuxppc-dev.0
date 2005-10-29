Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp11.wanadoo.fr (smtp11.wanadoo.fr [193.252.22.31])
	by ozlabs.org (Postfix) with ESMTP id E218D68630
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 15:39:54 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1102.wanadoo.fr (SMTP Server) with ESMTP id 2F8F61C0009F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 07:39:52 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-40-23.w82-126.abo.wanadoo.fr
	[82.126.157.23])
	by mwinf1102.wanadoo.fr (SMTP Server) with ESMTP id 12E2B1C00099
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 07:39:52 +0200 (CEST)
Date: Sat, 29 Oct 2005 07:37:49 +0200
From: Sven Luther <sl@bplan-gmbh.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051029053749.GA874@localhost.localdomain>
References: <20051025075159.GA10316@localhost.localdomain>
	<17251.265.196352.234376@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17251.265.196352.234376@cargo.ozlabs.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Sven Luther <sl@bplan-gmbh.de>
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

On Sat, Oct 29, 2005 at 02:56:41PM +1000, Paul Mackerras wrote:
> Sven Luther writes:
> 
> > +static struct pci_device_id pci_marvell_mv64360[] = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },
> 
> Are there other devices in this northbridge whose drivers might also
> want to bind to this PCI id?
> 
> What other devices does this northbridge contain?

Yep, Dale proposed to add : 

+       { PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64460) },

Which i was about to resubmit the patch when i saw the commit, ... Err, no i
misunderstood your question.

Other devices, well, there is the interrupt controller, some dma engine and
the builtin sram, but nothing to my knowledge which would benefit from being
bound to the pci id.

Friendly,

Sven Luther
