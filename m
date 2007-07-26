Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C89AADDF26
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 05:41:52 +1000 (EST)
Date: Thu, 26 Jul 2007 21:41:50 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
In-Reply-To: <20070725213925.2f25906c@the-village.bc.nu>
Message-ID: <Pine.LNX.4.60.0707262136530.6614@poirot.grange>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<Pine.LNX.4.60.0707252130090.6234@poirot.grange>
	<20070725213925.2f25906c@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Jul 2007, Alan Cox wrote:

> > driver to using platform-device. I got a reply, that it's not worth it now 
> > that IDE is slowly becoming obsolete, and the pata_platform serves the 
> > perpose perfectly well. I found this argument reasonable, I had the same 
> > doubt, just wanted to double-check. So, why do we now need a new legacy 
> > (a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver 
> > exists?
> 
> We don't *need* it but some people still want to use old IDE and the
> author was willing to make it neatly compatible so that anything that
> works with the pata_platform should be able to use the ide_platform
> driver and vice versa. For the shorter term that can only be a good thing
> - arch code doesn't need to care about which driver is used, end users
> can pick and it doesn't end up adding new ties between code and old IDE.

Ok, thanks for the explanation Alan. So, there's no technical argument, 
just "being nice to the users", and add a new driver, which we know we'll 
have to remove soon, thus having to persuade its users, who by that time 
will get used to it and will not want to invest money into switching to 
another one...

Thanks
Guennadi
---
Guennadi Liakhovetski
