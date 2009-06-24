Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 54BF9B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 19:33:02 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC2CBDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 19:33:01 +1000 (EST)
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1245824392.9237.85.camel@concordia>
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>  <4A3F4A77.6070704@ktk.bme.hu>
	<1245719890.4017.26.camel@pasglop> <1245724218.4017.35.camel@pasglop>
	<1245794228.10356.31.camel@pasglop> <1245799792.10356.42.camel@pasglop>
	<1245822826.9237.62.camel@concordia>
	<1245823019.10356.69.camel@pasglop>
	<1245824392.9237.85.camel@concordia>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 19:31:21 +1000
Message-Id: <1245835881.10356.71.camel@pasglop>
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

On Wed, 2009-06-24 at 16:19 +1000, Michael Ellerman wrote:

> sym53c8xx 0000:00:0c.0: enabling device (0140 -> 0143)
> sym0: <896> rev 0x7 at pci 0000:00:0c.0 irq 17
> sym0: No NVRAM, ID 7, Fast-40, SE, parity checking
> _mpic_irq_read: val 0x80480004 shadow 0x80080014
> _mpic_irq_read: val 0x480004 shadow 0x480004

Strange.. it's like we read a different vector and polarity than
what is in the cache. Oh well, I'll have a closer look tomorrow
in the office.

Ben.
