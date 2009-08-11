Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 01159B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 15:45:04 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CE66DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 15:45:01 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: need help getting SPI controller working on 405EX
Date: Tue, 11 Aug 2009 07:44:52 +0200
References: <1249574886.3747.2650.camel__48649.694157257$1249575290$gmane$org@localhost.localdomain>
	<h5mjg0$rqs$1@ger.gmane.org>
	<1249920435.3747.8569.camel@localhost.localdomain>
In-Reply-To: <1249920435.3747.8569.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908110744.52394.sr@denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Nathan French <nathan.french@onrampwireless.com>,
	Lorenz Kolb <lorenz.kolb.newsgroups.nospam@lkmail.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 10 August 2009 18:07:15 Nathan French wrote:
> > At least something similar worked for me some months ago (before we
> > switched to a "real" driver for some custom peripheral).
>
> Did this work on a 4xx PowerPC platform?  Or something else?  I've been
> told that there is no SPI driver for 4xx.  If you have done this on 4xx
> then I'm very interested.

The 4xx SPI driver is (finally) queued for 2.6.32. So you either need to 
manually apply it now or wait a while.

Best regards,
Stefan
