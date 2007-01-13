Return-Path: <anton@ozlabs.org>
Date: Sat, 13 Jan 2007 23:46:38 +1100
From: Anton Blanchard <anton@samba.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 7/19] powerpc: interfaces to the hypervisor of Celleb
Message-ID: <20070113124638.GA13493@krispykreme>
References: <200701120100.l0C10ktW025821@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701120100.l0C10ktW025821@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

Just a few suggestions.

> +#define	HCALL_MEDIUM	or 	2,2,2

Doesnt look like this is used.

> +#define	HVSC	.long	0x44000022

Could you pick this up from the define in include/asm-powerpc instead?

> +#define	LOAD_CONST64(r, const)					\
> +	lis	r, ((const)>>48)&0xFFFF;			\
> +	ori	r, r, ((const)>>32)&0xFFFF;			\
> +	rldicr	r, r, 32, 31;					\
> +	oris	r, r, ((const)>>16)&0xFFFF;			\
> +	ori	r, r, ((const)>>0)&0xFFFF

It doesnt look like this is used either.

Anton
