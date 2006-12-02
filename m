Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9777B67B8F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 22:33:10 +1100 (EST)
Subject: Re: [PATCH] linkstation / kurobox support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <1165058392.22108.34.camel@localhost.localdomain>
References: <Pine.LNX.4.60.0612012241430.13326@poirot.grange>
	<200612021156.37067.arnd@arndb.de>
	<1165058392.22108.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 22:32:59 +1100
Message-Id: <1165059179.22108.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Can't you use the new PCI probing from arch/powerpc/kernel/of_platform
> > for this?
> 
> I wouldnt recomment it for 32 bits just yet ...

To be more precise... I suspect the code in there will not work properly
for 32 bits. The PCI code is still very very very different between
ppc32 and ppc64 (and both are broken in different ways).

I do plan to try to fix all of that up, but it's a complicated problem
(and the "generic" code doesn't help much as it's also broken in
different ways).

So for now, PCI related things have to be quite different between ppc32
and ppc64 unfortunately...

Ben.
