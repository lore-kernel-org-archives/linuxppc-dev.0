Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 607C367BC6
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 22:34:35 +1000 (EST)
Subject: Re: RFC: Location for Device Tree Sources?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1154464346.19994.4.camel@cashmere.sps.mot.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 13:18:29 +0200
Message-Id: <1155122309.4040.94.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-01 at 15:32 -0500, Jon Loeliger wrote:
> Folks,
> 
> Where should we place the sources for the OF Flat Device
> Tree source files?  They used to be in U-Boot, but that
> isn't happening any more.

Why ? While having device-tree's in zImages is good to handle firmwares
that can't pass them, I still think that the proper thing to do is to
have the firmware provide the DT to the kernel. Did Denk decide once for
all against having DTs passed by uboot at all ? In which case, it's
probably time to consider a fork...

> One semi-obvious place would be to co-locate them with
> their corresponding Linux arch/powerpc/platform directory.
> Another would be to have a new directory full of them
> under, say, arch/powerpc/devtrees or so.
> 
> Are there other suggestions or better ideas?
> 
> Thanks,
> jdl
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
