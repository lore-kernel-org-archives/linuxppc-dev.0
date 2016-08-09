Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sS26sGJzDqf3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:42 +1000 (AEST)
In-Reply-To: <1470033171-20843-1-git-send-email-alastair@au1.ibm.com>
To: Alastair D'Silva <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Alastair D'Silva" <alastair@d-silva.org>
Subject: Re: powerpc: Fix unused function warning 'lmb_to_memblock'
Message-Id: <3s7sS25blGz9t1v@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-01-08 at 06:32:51 UTC, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This patch fixes the following warning:
> arch/powerpc/platforms/pseries/hotplug-memory.c:323:29: error: 'lmb_to_memblock' defined but not used [-Werror=unused-function]
> static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
>                            ^~~~~~~~~~~~~~~
> 
> The only consumer of this function is 'dlpar_remove_lmb', which is
> enabled with CONFIG_MEMORY_HOTREMOVE, so move it into the same
> ifdef block.

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9dc512819e4b723856773f5a01

cheers
