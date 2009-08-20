Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7D63FB6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 14:38:59 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 7A5C9DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 14:38:55 +1000 (EST)
Date: Thu, 20 Aug 2009 00:38:51 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Feng Kan <fkan@amcc.com>
Subject: Re: NAND  ECC Error with wrong SMC ording bug
Message-ID: <20090820003851.1a532444@lappy.seanm.ca>
In-Reply-To: <4A8C87E6.6070702@amcc.com>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<1250569482.19007.23.camel@pasglop> <4A8C87E6.6070702@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Aug 2009 16:16:54 -0700
Feng Kan <fkan@amcc.com> wrote:

> I see other boards using SMC as well, can someone comment on the
> change I am proposing.
> Should I change the correction algorithm or the calculate function?
> If the later is preferred
> it would mean the change must be pushed in both U-Boot and Linux.

Odds are the calculate function is wrong. The correction algo is used
by many nand drivers, I *assume* it is correct. The calculate function
was set to agree with u-boot (1.3.0).

Cheers,
   Sean

P.S. Yes, I know the u-boot is an ancient version :(
