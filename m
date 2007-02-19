Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFBF7DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 10:22:57 +1100 (EST)
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20070219234651.4a19a912@localhost.localdomain>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<200702151909.26082.arnd@arndb.de>
	<20070219215659.15539fb3@localhost.localdomain>
	<1171920081.18571.77.camel@localhost.localdomain>
	<20070219234651.4a19a912@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:18:14 +1100
Message-Id: <1171927094.18571.82.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>,
	James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-19 at 23:46 +0000, Alan wrote:
> > > into one in drivers/ide but really want splitting for libata with some
> > > kind of libata-pmac owning the shared stuff
> > 
> > You meand driver/ide/ppc/pmac.c ?
> 
> Yes
> 
> > moving them out of the macio_asic to a PCI device at one point, so yes,
> > maybe you are right, I should move the DMA bits to some "common" file
> > and split the various implementations.
> 
> I suspect it is worth doing when moving to libata at least, even if not
> for the older driver.

Yup. I don't when I'll have time to "libataify" it though. I need to
look into the best way of handling hotplug with the mediabay for that.
The current hacks are only really suitable for drivers/ide

Ben.
