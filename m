Return-Path: <dja@axtens.net>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D9871A0657
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 19:13:44 +1100 (AEDT)
Received: by pfcc203 with SMTP id c203so467476pfc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 00:13:41 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Valentin Rothberg <valentinrothberg@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Valentin Rothberg <valentinrothberg@gmail.com>, akpm@linux-foundation.org
Subject: Re: [PATCH] arch/powerpc/Kconfig: fix typo in select statement
In-Reply-To: <1449819988-28603-1-git-send-email-valentinrothberg@gmail.com>
References: <1449819988-28603-1-git-send-email-valentinrothberg@gmail.com>
Date: Fri, 11 Dec 2015 19:13:36 +1100
Message-ID: <87a8phjtcf.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Valentin.

Ironically I first noticed the spelling mistake in the original UBSAN
patchset[1], but wanted it to work on powerpc straight away so I went
with the mis-spelled version. It's since been corrected upstream[2]; and
I was going to spin a v2 of my original patch with this fix, especially
since I tagged the original patch as an RFC only. Regardless, thank you:
this should keep -mm and next working in the mean time!

> Fixes: 257e4ee82dbd ("powerpc: enable UBSAN support")
Is this a SHA from linux-next?

Regards,
Daniel

[1]: https://lkml.org/lkml/2015/12/9/1008
[2]: https://lkml.org/lkml/2015/12/10/422


> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> ---
> Detected with ./scripts/checkkconfigsymbols.py
>
>  arch/powerpc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b0420a8c458e..4de86d145f17 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -157,7 +157,7 @@ config PPC
>  	select EDAC_ATOMIC_SCRUB
>  	select ARCH_HAS_DMA_SET_COHERENT_MASK
>  	select HAVE_ARCH_SECCOMP_FILTER
> -	select ARCH_HAS_UBSAN_SANTIZE_ALL
> +	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  
>  config GENERIC_CSUM
>  	def_bool CPU_LITTLE_ENDIAN
> -- 
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
