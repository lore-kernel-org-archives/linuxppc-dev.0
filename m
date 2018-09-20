Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3Sh2Th7zF39H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:08 +1000 (AEST)
In-Reply-To: <20180918033617.15474-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.ibm.com>
Subject: Re: [v2] powerpc/configs: Update skiroot defconfig
Message-Id: <42G3Sg5fY6z9sBy@ozlabs.org>
Date: Thu, 20 Sep 2018 14:21:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-09-18 at 03:36:17 UTC, Joel Stanley wrote:
> Disable new features from recent releases, and clean out some other
> unused options:
> 
>   - Enable EXPERT, so we can disable some things
>   - Disable non-powerpc BPF decoders
>   - Disable TASKSTATS
>   - Disable unused syscalls
>   - Set more things to be modules
>   - Turn off unused network vendors
>   - PPC_OF_BOOT_TRAMPOLINE and FB_OF are unused on powernv
>   - Drop unused Radeon and Matrox GPU drivers
>   - IPV6 support landed in petitboot
>   - Bringup related command line powersave=off dropped, switch to quiet
> 
> Set CONFIG_I2C_CHARDEV=y as the module is not loaded automatically, and
> without this i2cget etc. will fail in the skiroot environment.
> 
> This defconfig gets us build coverage of KERNEL_XZ, which was broken in
> the 4.19 merge window for powerpc.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cbc39809a398b1a30c2bdb0f3123ee

cheers
