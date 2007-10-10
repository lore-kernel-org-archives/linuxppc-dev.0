Return-Path: <SRS0=iyrW=PE=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 21FC6DDF98
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 18:29:45 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [linux-usb-devel] [PATCH 0/3] usb: ehci ppc device-tree-aware
	driver
Date: Wed, 10 Oct 2007 10:30:02 +0200
References: <20070924192519.GA4192@ru.mvista.com>
	<200710092327.26109.david-b@pacbell.net>
	<200710101015.46308.arnd@arndb.de>
In-Reply-To: <200710101015.46308.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710101030.02349.sr@denx.de>
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 10 October 2007, Arnd Bergmann wrote:
> > Do PPC folk sign off on how this is done?
> >
> > I don't follow all the ins/outs of the OF devtree stuff...
>
> The driver looks good to me, both the interaction with the of_platform_bus
> layer and the handling of I/O addresses. I haven't actually tried running
> it, but I'm rather confident that if it works on the Sequoia, it should
> also do the right thing on any other powerpc system that has an EHCI on
> some other (non-PCI) bus.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
