Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6CF2DDE05
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 05:39:29 +1100 (EST)
Date: Wed, 5 Dec 2007 12:39:12 -0600
From: Scott Wood <scottwood@freescale.com>
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v2 2/4] [libata] pata_of_platform: OF-Platform PATA
	device driver
Message-ID: <20071205183912.GA4516@loki.buserror.net>
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170719.GB15599@localhost.localdomain>
	<20071204184826.GA5758@lixom.net>
	<20071204194921.GB1253@localhost.localdomain>
	<20071204200121.GA6782@lixom.net>
	<20071205004841.GA25905@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071205004841.GA25905@linux-sh.org>
Cc: Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 05, 2007 at 09:48:41AM +0900, Paul Mundt wrote:
> On Tue, Dec 04, 2007 at 02:01:21PM -0600, Olof Johansson wrote:
> > On Tue, Dec 04, 2007 at 10:49:21PM +0300, Anton Vorontsov wrote:
> > >  	tristate "Generic platform device PATA support"
> > > -	depends on EMBEDDED || ARCH_RPC
> > > +	depends on EMBEDDED || ARCH_PPC
> > 
> > It needs to be || PPC, not || ARCH_PPC.
> > 
> Wrong. It needs to be EMBEDDED || ARCH_RPC || PPC.

Why is it dependent on anything other than platform bus support and ATA?

-Scott
