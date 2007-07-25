Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 3145FDDEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 05:37:30 +1000 (EST)
Date: Wed, 25 Jul 2007 21:37:26 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
In-Reply-To: <20070725165318.5331.23795.stgit@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0707252130090.6234@poirot.grange>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Jul 2007, Vitaly Bordug wrote:

> 
> This is now very similar to pata_platform.c, they both use
> same platform data structure and same resources.
> 
> To achieve that, byte_lanes_swapping platform data variable
> and platform specified iops removed from that driver. It's fine,
> since those were never used anyway.
> 
> pata_platform and ide_platform are carrying same driver names,
> to easily switch between these drivers, without need to touch
> platform code.

Why? There's a drivers/ide/arm/ide_arm.c IDe driver that some platforms 
(not in the mainline) hack to access, e.g., CF cards in true-IDE mode. 
About a month ago I submitted a patch to arm-linux-kernel switching that 
driver to using platform-device. I got a reply, that it's not worth it now 
that IDE is slowly becoming obsolete, and the pata_platform serves the 
perpose perfectly well. I found this argument reasonable, I had the same 
doubt, just wanted to double-check. So, why do we now need a new legacy 
(a/drivers/ide/legacy/ide_platform.c) driver when a "modern" driver 
exists?

Thanks
Guennadi
---
Guennadi Liakhovetski
