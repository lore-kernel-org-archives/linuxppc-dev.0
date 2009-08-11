Return-Path: <nathan.french@onrampwireless.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 97400B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 01:59:33 +1000 (EST)
Received: from relay.ihostexchange.net (relay.ihostexchange.net [66.46.182.55])
	by ozlabs.org (Postfix) with ESMTP id 1178ADDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 01:59:32 +1000 (EST)
Subject: Re: need help getting SPI controller working on 405EX
From: Nathan French <nathan.french@onrampwireless.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200908110744.52394.sr@denx.de>
References: <1249574886.3747.2650.camel__48649.694157257$1249575290$gmane$org@localhost.localdomain>
	<h5mjg0$rqs$1@ger.gmane.org>
	<1249920435.3747.8569.camel@localhost.localdomain>
	<200908110744.52394.sr@denx.de>
Content-Type: text/plain
Date: Tue, 11 Aug 2009 08:59:26 -0700
Message-ID: <1250006366.3747.8595.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Lorenz Kolb <lorenz.kolb.newsgroups.nospam@lkmail.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is good news.  Can you point me towards the patch for that?

Nathan

On Tue, 2009-08-11 at 01:44 -0400, Stefan Roese wrote:
> On Monday 10 August 2009 18:07:15 Nathan French wrote:
> > > At least something similar worked for me some months ago (before we
> > > switched to a "real" driver for some custom peripheral).
> >
> > Did this work on a 4xx PowerPC platform?  Or something else?  I've been
> > told that there is no SPI driver for 4xx.  If you have done this on 4xx
> > then I'm very interested.
> 
> The 4xx SPI driver is (finally) queued for 2.6.32. So you either need to 
> manually apply it now or wait a while.
> 
> Best regards,
> Stefan
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
