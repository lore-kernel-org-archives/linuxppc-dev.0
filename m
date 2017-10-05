Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y702v53DvzDr1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:21:43 +1100 (AEDT)
In-Reply-To: <20171004042324.32129-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [v2] powerpc: configs: Add Skiroot defconfig
Message-Id: <3y702t5l1Xz9t5n@ozlabs.org>
Date: Thu,  5 Oct 2017 15:21:42 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-04 at 04:23:24 UTC, Joel Stanley wrote:
> This configuration is used by the OpenPower firmware for it's
> Linux-as-bootloader implementation. Also known as the Petitboot kernel,
> this configuration broke in 4.12 (CPU_HOTPLUG=n), so add it to the
> upstream tree in order to get better coverage.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c3dda4b0db9cf5044010e4de88e5e5

cheers
