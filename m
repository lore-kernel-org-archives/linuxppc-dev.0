Return-Path: <imp@bsdimp.com>
Received: from harmony.bsdimp.com (bsdimp.com [199.45.160.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBDAEDE0E0
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 09:33:35 +1100 (EST)
Date: Mon, 26 Jan 2009 15:26:20 -0700 (MST)
Message-Id: <20090126.152620.1498421823.imp@bsdimp.com>
To: matt@genesi-usa.com
Subject: Re: [PATCH 10/10] mmc: Add OpenFirmware bindings for SDHCI driver
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <497C09D9.50004@genesi-usa.com>
References: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
	<20090122020041.GJ11492@oksana.dev.rtsoft.ru>
	<497C09D9.50004@genesi-usa.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sdhci-devel@list.drzeus.cx, arnd@arndb.de, DaveLiu@freescale.com,
	Joe.D'abbraccio@freescale.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Konjin.Lai@freescale.com,
	ben-linux@fluff.org, drzeus-sdhci@drzeus.cx, X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: <497C09D9.50004@genesi-usa.com>
            Matt Sealey <matt@genesi-usa.com> writes:
: Anton Vorontsov wrote:
: >  
: >  	  If unsure, say Y.
: >  
: > +config MMC_SDHCI_OF
: > +	tristate "SDHCI support on OpenFirmware platforms"
: > +	depends on MMC_SDHCI && PPC_OF
: > +	help
: > +	  This selects the OF Secure Digital Host Controller Interface.
: > +	  So far there is only Freescale eSDHC controller known to exists
: > +	  on OF platforms.
: 
: Nit; would probably be better English as
: 
: 	This selects the OF support for Secure Digital Host Controller
: 	Interfaces. So far, only the Freescale eSDHC controller is known
: 	to exist on OF platforms.

Is this the SD Association standard host controller interface, or a
custom one by Freescale?  If the former, then I'd suggest:

	This selects OF support for the SD Association standard Secure
	Digital Host Controller Interface (version x.xx).  So far,
	only the Freescale eSDHC controller is the only example on OF
	platforms.

if the latter:

	This selects OF support for Freescale's custom Secure Digital
	Host Controller Interface.  So far, only the Freescale eSDHC
	controller is the only example on OF platforms.

Warner
