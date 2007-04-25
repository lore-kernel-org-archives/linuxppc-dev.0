Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59385DDF1F
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 11:03:42 +1000 (EST)
In-Reply-To: <1177459651.14873.164.camel@localhost.localdomain>
References: <20070424223245.78f4fdfb.sfr@canb.auug_.org.au>
	<f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C011ECCD1@az33exm24.fsl.freescale.net>
	<20070424.110456.124867547.davem@davemloft.net>
	<1177459651.14873.164.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c65c2fcf295f9b4a40292156b5258012@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
Date: Wed, 25 Apr 2007 03:03:31 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Miller <davem@davemloft.net>, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Dave, no need to shout :-) I think it's pretty well agreed that
> Stephen's patches are good to go (unless nits I haven't seen), we are
> really just discussing what we should do on top of them.

Yes.  And I dare say that we should agree that certain
fixes *should* go on top or this consolidation shouldn't
happen at all -- at least not as a consolidation to a
"generic" OF layer.  For example, the OLPC device tree / OF
kernel efforts would be dead in the water if we cannot
have a *proper* "#address-cells" parser.

Again, I have *nothing* against Stephen's patches, I find
them quite nice actually.  It's just that if this stuff
gets moved to a "for all archs" layer, some "design
qualms" need to be cleared up; either that, or we'll
end up with the OF analogue to an MSI layer that only
ever can work on intel compatible platforms.


Segher
