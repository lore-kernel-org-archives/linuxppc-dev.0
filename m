Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2CC82B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 02:11:57 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C958DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 02:11:54 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Nathan French <nathan.french@onrampwireless.com>
Subject: Re: need help getting SPI controller working on 405EX
Date: Tue, 11 Aug 2009 18:11:30 +0200
References: <1249574886.3747.2650.camel__48649.694157257$1249575290$gmane$org@localhost.localdomain>
	<200908110744.52394.sr@denx.de>
	<1250006366.3747.8595.camel@localhost.localdomain>
In-Reply-To: <1250006366.3747.8595.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908111811.30317.sr@denx.de>
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

On Tuesday 11 August 2009 17:59:26 Nathan French wrote:
> This is good news.  Can you point me towards the patch for that?

Sure. Latest version is: "[PATCH v8] spi: Add PPC4xx SPI driver":

http://article.gmane.org/gmane.linux.ports.ppc64.devel/57940

Best regards,
Stefan
