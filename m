Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp6.wanadoo.fr (smtp6.wanadoo.fr [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id 2D67868593
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2005 05:59:24 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0603.wanadoo.fr (SMTP Server) with ESMTP id C048C1C001E6
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Oct 2005 21:59:20 +0200 (CEST)
Date: Thu, 27 Oct 2005 21:57:39 +0200
From: Sven Luther <sl@bplan-gmbh.de>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20051027195738.GA13170@localhost.localdomain>
References: <20051025075159.GA10316@localhost.localdomain>
	<20051025182434.GA13982@xyzzy.farnsworth.org>
	<20051027192655.GA13945@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051027192655.GA13945@lst.de>
Cc: Sven Luther <sl@bplan-gmbh.de>, linuxppc-dev@ozlabs.org
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

On Thu, Oct 27, 2005 at 09:26:55PM +0200, Christoph Hellwig wrote:
> > I don't think this is really dependent on PPC_MULTIPLATFORM,
> > and the driver also supports 64460.
> 
> This is not a PCI driver so adding a device table is wrong.

Sure, please provide us with a patch to add hotplug support to those platform
drivers who are not pci :)

In the meantime, this is no worse than how this was done previously, namely
having discover match the northbridge pci id.

Friendly,

Sven Luther
