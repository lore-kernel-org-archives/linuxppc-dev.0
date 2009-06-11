Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2873AB70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:30:14 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C705DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:30:13 +1000 (EST)
Subject: Re: next branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20090610210923.2323202f@lappy.seanm.ca>
References: <1242890760.5109.1.camel@pasglop>
	<20090610175602.722bf68d@lappy.seanm.ca>
	<1244681452.5739.7.camel@pasglop>
	<20090610210923.2323202f@lappy.seanm.ca>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 11:30:07 +1000
Message-Id: <1244683807.5739.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 21:09 -0400, Sean MacLennan wrote:
> I was expecting an rc9 and another week. Probably others where caught
> off guard. Patch below.
> 
Note that this simple patch qualifies as a bug fix in my book and thus
is less constrainted. I would happily have merged it in -rc4 :-)

Cheers,
Ben.
