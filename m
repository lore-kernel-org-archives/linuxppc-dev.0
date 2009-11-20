Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C5611007D1
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 04:38:55 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAKHcpj1021655
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 10:38:52 -0700 (MST)
Date: Fri, 20 Nov 2009 11:38:59 -0600
From: Scott Wood <scottwood@freescale.com>
To: Mahajan Vivek-B08308 <B08308@freescale.com>
Subject: Re: [PATCH v3 3/3] powerpc/fsl: 85xx: add cache-sram support
Message-ID: <20091120173859.GC18967@loki.buserror.net>
References: <181208B7-AC0B-4634-A04E-46468D376719@freescale.com>
	<F2F605B667B24B489C904986E0D60A08012221DF@zin33exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F2F605B667B24B489C904986E0D60A08012221DF@zin33exm23.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>,
	Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 19, 2009 at 11:45:32PM -0700, Mahajan Vivek-B08308 wrote:
> > I really don't like setting the physical address this way, 
> > can we not do this via the device tree?
> 
> Cache-sram does not have any device tree entry since it is not a 
> hardware as such. Putting it under chosen can be another option.
> I think, Scott (cc'ed) was of the opinion that since 32b base 
> address support is missing; so there is no point in moving this 
> address to the command line and .config should be okay for now 
> for it.

I don't know what you mean by "32b base address support is missing".  I have
no objection to putting it on the command line.

-Scott
