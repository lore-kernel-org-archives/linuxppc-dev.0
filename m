Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD347DDDCF
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 10:31:59 +1100 (EST)
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200702200017.32924.bzolnier@gmail.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<1171920081.18571.77.camel@localhost.localdomain>
	<20070219234651.4a19a912@localhost.localdomain>
	<200702200017.32924.bzolnier@gmail.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:28:40 +1100
Message-Id: <1171927720.18571.84.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>,
	James K Lewis <jim@jklewis.com>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-20 at 00:17 +0100, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 20 February 2007 00:46, Alan wrote:
> > > > into one in drivers/ide but really want splitting for libata with some
> > > > kind of libata-pmac owning the shared stuff
> > > 
> > > You meand driver/ide/ppc/pmac.c ?
> > 
> > Yes
> > 
> > > moving them out of the macio_asic to a PCI device at one point, so yes,
> > > maybe you are right, I should move the DMA bits to some "common" file
> > > and split the various implementations.
> > 
> > I suspect it is worth doing when moving to libata at least, even if not
> > for the older driver.
> 
> fully agreed, the way to go for both drivers

I don't think it's worth touching the drivers/ide version.

Ben.
