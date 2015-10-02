Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10CD31A04E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 17:47:09 +1000 (AEST)
In-Reply-To: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mmarek@suse.com, linux-kernel@vger.kernel.org, yann.morin.1998@free.fr,
 linux-kbuild@vger.kernel.org
Subject: Re: [RFC,
 1/2] scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG to be a target
Message-Id: <20151002074708.CF4DC14076A@ozlabs.org>
Date: Fri,  2 Oct 2015 17:47:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-23-09 at 05:40:34 UTC, Michael Ellerman wrote:
> Arch Makefiles can set KBUILD_DEFCONFIG to tell kbuild the name of the
> defconfig that should be built by default.
> 
> However currently there is an assumption that KBUILD_DEFCONFIG points to
> a file at arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG).
> 
> We would like to use a target, using merge_config, as our defconfig, so
> adapt the logic in scripts/kconfig/Makefile to allow that.
> 
> To minimise the chance of breaking anything, we first check if
> KBUILD_DEFCONFIG is a file, and if so we do the old logic. If it's not a
> file, then we call the top-level Makefile with KBUILD_DEFCONFIG as the
> target.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Michal Marek <mmarek@suse.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/d2036f30cfe1daa19e63ce75

cheers
