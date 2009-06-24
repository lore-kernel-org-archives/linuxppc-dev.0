Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 72F09B70C7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 15:58:37 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0158DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 15:58:36 +1000 (EST)
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1245822826.9237.62.camel@concordia>
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>  <4A3F4A77.6070704@ktk.bme.hu>
	<1245719890.4017.26.camel@pasglop> <1245724218.4017.35.camel@pasglop>
	<1245794228.10356.31.camel@pasglop> <1245799792.10356.42.camel@pasglop>
	<1245822826.9237.62.camel@concordia>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 15:56:59 +1000
Message-Id: <1245823019.10356.69.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, blackluck@ktk.bme.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-24 at 15:53 +1000, Michael Ellerman wrote:
> Doesn't fix my machine :/
> 
That doesn't make sense ... What if you remove the bit inside the ifdef
CONFIG_MPIC_BROKEN_REGREAD in _mpic_read() ?

If that makes a difference, then it would be interesting to add a printk
in there that prints what the original value "val" is and what we have
in the shadow...

Cheers,
Ben.
