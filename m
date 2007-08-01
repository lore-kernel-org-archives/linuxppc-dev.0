Return-Path: <dgibson@ozlabs.org>
Date: Wed, 1 Aug 2007 12:09:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 3/6] PowerPC 440EPx: 440EPx/440EP dcr defines
Message-ID: <20070801020936.GC31391@localhost.localdomain>
References: <20070730151245.GA5027@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070730151245.GA5027@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2007 at 07:12:45PM +0400, Valentine Barshak wrote:
> This patch adds DCR defines needed for 440EP/440EPx clock initialization.
> These defines have been introduced in the Bamboo support by Josh Boyer
> and are needed for Sequoia as well.

These should really go in the same patch that uses them.  I dislike
this business of splitting patches up when the parts are functionally
dependent on each other.

> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  arch/powerpc/boot/dcr.h |   11 +++++++++++
>  1 files changed, 11 insertions(+)
> 
> diff -ruN linux.orig/arch/powerpc/boot/dcr.h linux/arch/powerpc/boot/dcr.h
> --- linux.orig/arch/powerpc/boot/dcr.h	2007-07-27 20:37:10.000000000 +0400
> +++ linux/arch/powerpc/boot/dcr.h	2007-07-27 21:06:11.000000000 +0400
> @@ -121,4 +121,15 @@
>  #define DCRN_CPC0_MIRQ1					0x0ed
>  #define DCRN_CPC0_JTAGID				0x0ef
>  
> +/* 440EP/440EPx  Clock/Power-on Reset regs */
> +#define DCRN_CPR0_ADDR	0xc
> +#define DCRN_CPR0_DATA	0xd
> +#define CPR0_PLLD0	0x60
> +#define CPR0_OPBD0	0xc0
> +#define CPR0_PERD0	0xe0
> +#define CPR0_PRIMBD0	0xa0
> +#define CPR0_SCPID	0x120
> +#define CPR0_PLLC0	0x40
> +
> +
>  #endif	/* _PPC_BOOT_DCR_H_ */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
