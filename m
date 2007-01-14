Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de",
	Issuer "HE CA - G01" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7626FDDEC9
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 12:13:46 +1100 (EST)
Date: Sun, 14 Jan 2007 01:49:14 +0100
From: Adrian Reber <adrian@lisas.de>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] maple: improve CPC9x5 host bridge detection
Message-ID: <20070114004914.GA30174@lisas.de>
References: <20070103185628.GE6279@localdomain>
	<1167857446.6165.155.camel@localhost.localdomain>
	<20070103211117.GF6279@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070103211117.GF6279@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 03, 2007 at 03:11:17PM -0600, Nathan Lynch wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2007-01-03@12:56 -0600, Nathan Lynch wrote:
> > > Identify CPC9x5 PCI Express, AGP, and HT host bridges using
> > > device_type and compatible properties, which is a more flexible method
> > > than using the name property (which can differ between firmwares and
> > > models).
> > > 
> > > Signed-off-by: Nathan Lynch <ntl@pobox.com>
> > 
> > Do that work on js20/js21 with SLOF ?
> 
> Not sure, I'll see whether I can test one of those.

I have tested it on js20/js21 with SLOF and it works.

		Adrian
