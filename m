Return-Path: <bn@niasdigital.com>
Received: from outbound.icp-qv1-irony-out2.iinet.net.au
	(outbound.icp-qv1-irony-out2.iinet.net.au [203.59.1.107])
	by ozlabs.org (Postfix) with ESMTP id 6F100DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 16:42:57 +1000 (EST)
Subject: Re: UIO not working on ppc405 onchip registers
From: Ben Nizette <bn@niasdigital.com>
To: Markus Brunner <super.firetwister@googlemail.com>
In-Reply-To: <20080722061730.GB12576@digi.com>
References: <200807212152.16080.super.firetwister@gmail.com>
	<20080722061730.GB12576@digi.com>
Content-Type: text/plain
Date: Tue, 22 Jul 2008 16:42:47 +1000
Message-Id: <1216708967.4004.238.camel@moss.renham>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hey Markus,

> > 
> > +config UIO_GPIO
> > +       tristate "Driver for PPC_4xx GPIO"

As an aside, you sure you want to do this anyway?  I'd suggest that you
just do a gpio chip driver for this, tie it in to gpiolib and use the
gpiolib user interface (which IIRC has only made it as far as -mm but is
on the way up).  This gives kernel internals nice access to the pins as
well through the standard gpio framework.

Thanks :-)
	--Ben.
