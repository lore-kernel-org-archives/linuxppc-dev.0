Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from localhost.localdomain (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05167DDD07
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 09:44:09 +1100 (EST)
Date: Mon, 19 Feb 2007 23:46:51 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Message-ID: <20070219234651.4a19a912@localhost.localdomain>
In-Reply-To: <1171920081.18571.77.camel@localhost.localdomain>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<200702151909.26082.arnd@arndb.de>
	<20070219215659.15539fb3@localhost.localdomain>
	<1171920081.18571.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org, Andrew, linux-ide@vger.kernel.org,
	paulus@samba.org, Morton <akpm@linux-foundation.org>,
	James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > into one in drivers/ide but really want splitting for libata with some
> > kind of libata-pmac owning the shared stuff
> 
> You meand driver/ide/ppc/pmac.c ?

Yes

> moving them out of the macio_asic to a PCI device at one point, so yes,
> maybe you are right, I should move the DMA bits to some "common" file
> and split the various implementations.

I suspect it is worth doing when moving to libata at least, even if not
for the older driver.

Alan
