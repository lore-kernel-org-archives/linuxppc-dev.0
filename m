Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7F7067D08
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 07:29:29 +1100 (EST)
Subject: Re: [PATCH 23/31] powerpc: Cell "Spider" MMIO workarounds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061107115541.GA32171@lst.de>
References: <1162884150.435786.961370643810.qpush@grosgo>
	<20061107072414.87D5F688CC@ozlabs.org> <20061107115541.GA32171@lst.de>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 07:29:19 +1100
Message-Id: <1162931359.28571.489.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-11-07 at 12:55 +0100, Christoph Hellwig wrote:
> On Tue, Nov 07, 2006 at 06:22:57PM +1100, Benjamin Herrenschmidt wrote:
> > + * This driver adds basic cpufreq support for SMU & 970FX based G5 Macs,
> > + * that is iMac G5 and latest single CPU desktop.
> 
> This doesn't make any sense ;-)

Ooops :-) Yeah, I copy/pasted the boilerplate and it looks like I copied
a bit too much :-)

Ben
