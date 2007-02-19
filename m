Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from localhost.localdomain (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B82D4DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 08:07:15 +1100 (EST)
Date: Mon, 19 Feb 2007 21:56:59 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Message-ID: <20070219215659.15539fb3@localhost.localdomain>
In-Reply-To: <200702151909.26082.arnd@arndb.de>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<200702151909.26082.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>, James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I fear that the hardest part is yet to come, when we integrate the
> driver for the the PS3 (currently called gelic_net) into spidernet.
> The trouble is that the hardware is sufficiently similar to share
> all the high-level mechanisms like the DMA data structures and
> descriptor chains, but the low-level mechanisms are hidden in the
> hypervisor on the PS3. Someone will have to invest a significant
> amount of time coordinating this so we don't break celleb and qs20
> in the process.

That to me implies they should be different drivers using a common
libata-something file. The PPC mac drivers likewise are currently mashed
into one in drivers/ide but really want splitting for libata with some
kind of libata-pmac owning the shared stuff

Alan
