Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcGN862hNzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 11:33:44 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id u26so14296025pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 18:33:44 -0700 (PDT)
Date: Tue, 30 May 2017 11:33:32 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/7] powerpc/mm: rename map_page() to map_kernel_page()
 on PPC32
Message-ID: <20170530113332.763d10ac@firefly.ozlabs.ibm.com>
In-Reply-To: <83aadb3163da87ec017ca4a61afcc29520a27eff.1496070452.git.christophe.leroy@c-s.fr>
References: <cover.1496070452.git.christophe.leroy@c-s.fr>
 <83aadb3163da87ec017ca4a61afcc29520a27eff.1496070452.git.christophe.leroy@c-s.fr>
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

On Mon, 29 May 2017 17:31:56 +0200 (CEST)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
...

> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index de5a90e1ceaa..8e9bef964dbf 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -305,11 +305,11 @@ void __init paging_init(void)
>  	unsigned long end = __fix_to_virt(FIX_HOLE);
>  
>  	for (; v < end; v += PAGE_SIZE)
> -		map_page(v, 0, 0); /* XXX gross */
> +		map_kernel_page(v, 0, 0); /* XXX gross */

What is 0, 0? Everything maps to physical address 0 with 0 permissions?


Thanks for doing this

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir
