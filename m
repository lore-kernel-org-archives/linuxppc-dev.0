Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75101DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 03:53:56 +1100 (EST)
Date: Wed, 28 Nov 2007 10:53:35 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][DTC] Fix whitespace in libfdt/fdt.h
Message-ID: <20071128165335.GA4597@loki.buserror.net>
References: <Pine.LNX.4.64.0711280938440.3013@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0711280938440.3013@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 28, 2007 at 09:39:08AM -0600, Kumar Gala wrote:
> Take from u-boot whitespace fixup of the file
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  libfdt/fdt.h |   32 ++++++++++++++++----------------
>  1 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/libfdt/fdt.h b/libfdt/fdt.h
> index e00559a..48ccfd9 100644
> --- a/libfdt/fdt.h
> +++ b/libfdt/fdt.h
> @@ -4,22 +4,22 @@
>  #ifndef __ASSEMBLY__
> 
>  struct fdt_header {
> -	uint32_t magic;                  /* magic word FDT_MAGIC */
> -	uint32_t totalsize;              /* total size of DT block */
> -	uint32_t off_dt_struct;          /* offset to structure */
> -	uint32_t off_dt_strings;         /* offset to strings */
> -	uint32_t off_mem_rsvmap;         /* offset to memory reserve map */
> -	uint32_t version;                /* format version */
> -	uint32_t last_comp_version;      /* last compatible version */
> -
> -        /* version 2 fields below */
> -	uint32_t boot_cpuid_phys;        /* Which physical CPU id we're
> +	uint32_t magic;			 /* magic word FDT_MAGIC */
> +	uint32_t totalsize;		 /* total size of DT block */
> +	uint32_t off_dt_struct;		 /* offset to structure */
> +	uint32_t off_dt_strings;	 /* offset to strings */
> +	uint32_t off_mem_rsvmap;	 /* offset to memory reserve map */
> +	uint32_t version;		 /* format version */
> +	uint32_t last_comp_version;	 /* last compatible version */

I don't think this is an improvement...  tabs are great for indentation, but
they suck for alignment.

-Scott
