Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D27A268583
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2005 05:27:07 +1000 (EST)
Date: Thu, 27 Oct 2005 21:26:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dale Farnsworth <dale@farnsworth.org>
Message-ID: <20051027192655.GA13945@lst.de>
References: <20051025075159.GA10316@localhost.localdomain>
	<20051025182434.GA13982@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051025182434.GA13982@xyzzy.farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>
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

> I don't think this is really dependent on PPC_MULTIPLATFORM,
> and the driver also supports 64460.

This is not a PCI driver so adding a device table is wrong.
