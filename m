Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 48300DDD0E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 10:11:30 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so587439ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 15:11:29 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Tue, 20 Feb 2007 00:17:32 +0100
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<1171920081.18571.77.camel@localhost.localdomain>
	<20070219234651.4a19a912@localhost.localdomain>
In-Reply-To: <20070219234651.4a19a912@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702200017.32924.bzolnier@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
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


On Tuesday 20 February 2007 00:46, Alan wrote:
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

fully agreed, the way to go for both drivers

Bart
