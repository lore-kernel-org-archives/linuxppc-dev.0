Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPx546H64zDvxJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 10:59:20 +1100 (AEDT)
In-Reply-To: <1479869713-30059-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: powerpc/boot: fix the early OPAL console wrappers
Message-Id: <3tPx5366f6z9t1B@ozlabs.org>
Date: Fri, 25 Nov 2016 10:59:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-23 at 02:55:13 UTC, Oliver O'Halloran wrote:
> When configured with CONFIG_PPC_EARLY_DEBUG_OPAL=y the kernel expects
> the OPAL entry and base addresses to be passed in r8 and r9
> respectively. Currently the wrapper does not attempt to restore these
> values before entering the decompressed kernel which causes the kernel
> to branch into whatever happens to be in r9 when doing a write to the
> OPAL console in early boot.
> 
> This patch adds a platform_ops hook that can be used to branch into the
> new kernel. The OPAL console driver patches this at runtime so that if
> the console is used it will be restored just prior to entering the
> kernel.
> 
> Fixes: 656ad58ef19e
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a1ff57416af9a7971a801d553cd53e

cheers
