Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9ABAB67A5E
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 01:20:46 +1000 (EST)
Date: Fri, 11 Aug 2006 01:20:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH] ehea: PPC - New hcall opcode defines
Message-Id: <20060811012044.1c8fcd20.sfr@canb.auug.org.au>
In-Reply-To: <44DB4B38.9030502@de.ibm.com>
References: <44DB4B38.9030502@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: tklein@de.ibm.com, linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	meder@de.ibm.com, themann@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 Aug 2006 17:05:28 +0200 Thomas Klein <osstklei@de.ibm.com> wrote:
>
> diff -Nurp -X dontdiff linux-2.6.18-rc4/include/asm-powerpc/hvcall.h patched_kernel/include/asm-powerpc/hvcall.h
> --- linux-2.6.18-rc4/include/asm-powerpc/hvcall.h	2006-08-06 11:20:11.000000000 -0700
> +++ patched_kernel/include/asm-powerpc/hvcall.h	2006-08-10 06:26:33.018907062 -0700
> @@ -201,6 +201,19 @@
>   #define H_JOIN			0x298
>   #define H_VASI_STATE            0x2A4
>   #define H_ENABLE_CRQ		0x2B0
> +#define H_ALLOC_HEA_RESOURCE	0x278
> +#define H_MODIFY_HEA_QP		0x250
> +#define H_QUERY_HEA_QP		0x254
> +#define H_QUERY_HEA		0x258
> +#define H_QUERY_HEA_PORT	0x25C
> +#define H_MODIFY_HEA_PORT	0x260
> +#define H_REG_BCMC		0x264
> +#define H_DEREG_BCMC		0x268
> +#define H_REGISTER_HEA_RPAGES	0x26C
> +#define H_DISABLE_AND_GET_HEA	0x270
> +#define H_GET_HEA_INFO		0x274
> +#define H_ADD_CONN		0x284
> +#define H_DEL_CONN		0x288

This patch appears to be whitespace damaged and it would be preferable if
the new defines were in there correct places in numerical order.

Thanks.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
