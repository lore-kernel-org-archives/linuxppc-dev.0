Return-Path: <nd@bplan-gmbh.de>
Received: from natfrord.rzone.de (natfrord.rzone.de [81.169.145.161])
	by ozlabs.org (Postfix) with ESMTP id 2924168572
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2005 07:14:57 +1000 (EST)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20051027192655.GA13945@lst.de>
References: <20051025075159.GA10316@localhost.localdomain>
	<20051025182434.GA13982@xyzzy.farnsworth.org>
	<20051027192655.GA13945@lst.de>
Content-Type: text/plain; charset=iso-8859-15
Date: Thu, 27 Oct 2005 23:14:45 +0200
Message-Id: <1130447685.5384.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Sven Luther <sl@bplan-gmbh.de>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_pcidev - implements
	hotplug for the marvell gige functionality by probing the northbridge
	pci id.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le jeudi 27 octobre 2005 à 21:26 +0200, Christoph Hellwig a écrit :
> > I don't think this is really dependent on PPC_MULTIPLATFORM,
> > and the driver also supports 64460.
> 
> This is not a PCI driver so adding a device table is wrong.
> 

I think we all agree ;-).

The point is to have a 'quick' way to get this module automagicly loaded
until we get a proper super duper OFW devices hotplug or whatsoeever
support.

Regards
