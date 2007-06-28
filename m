Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 749B5DDF67
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 10:14:13 +1000 (EST)
Date: Thu, 28 Jun 2007 10:14:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/8] [POWERPC] Use global_number in ppc32 pci_controller
Message-Id: <20070628101401.6790aafd.sfr@canb.auug.org.au>
In-Reply-To: <11829683663762-git-send-email-galak@kernel.crashing.org>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
	<11829683604166-git-send-email-galak@kernel.crashing.org>
	<11829683612573-git-send-email-galak@kernel.crashing.org>
	<11829683631074-git-send-email-galak@kernel.crashing.org>
	<11829683663762-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

All this stuff looks good, thanks.

On Wed, 27 Jun 2007 13:19:14 -0500 Kumar Gala <galak@kernel.crashing.org> wrote:
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> new file mode 100644
> index 0000000..3ca8cfb
> --- /dev/null
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -0,0 +1,53 @@
> +/*
> + * Contains common pci routines for ALL ppc platform
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

This needs some copyright notice presumably based on the code you are
moving to here.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
