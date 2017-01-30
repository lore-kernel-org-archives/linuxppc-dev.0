Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBksr1hJZzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 20:41:04 +1100 (AEDT)
Date: Mon, 30 Jan 2017 20:41:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 paulmck@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] powerpc: sort Kconfig selects under CONFIG_PPC
Message-ID: <20170130204102.423cebea@canb.auug.org.au>
In-Reply-To: <20170130093002.22180-1-andrew.donnellan@au1.ibm.com>
References: <87y3xtw62l.fsf@concordia.ellerman.id.au>
 <20170130093002.22180-1-andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

On Mon, 30 Jan 2017 20:30:02 +1100 Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:
>
> config PPC has a lot of selects under it. They're not sorted in any
> particular order, leading to merge conflicts when adding items at the end.
> 
> Sort them alphabetically.

Excellent, thanks.

> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> ---
> 
> On top of linux-next 20170130

Probably best done on top of powerpc-next and I can cope with the
conflicts one more time.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 689cf9218b21..570195c8a86a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -80,91 +80,91 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
>  config PPC

Could we add a comment just above asking that the selects be kept in order?

>  	bool
>  	default y
> -	select BUILDTIME_EXTABLE_SORT
> +	select ARCH_HAS_DEVMEM_IS_ALLOWED
> +	select ARCH_HAS_DMA_SET_COHERENT_MASK
-- 
Cheers,
Stephen Rothwell
