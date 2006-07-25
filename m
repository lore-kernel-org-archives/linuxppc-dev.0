Return-Path: <anton@ozlabs.org>
Date: Wed, 26 Jul 2006 00:41:24 +1000
From: Anton Blanchard <anton@samba.org>
To: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>
Subject: Re: [PATCH] clean up pseries hcall interfaces
Message-ID: <20060725144124.GA3769@krispykreme>
References: <591B6A09961C354991CD653B274DC8C2023662CB@ussdixms03.am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <591B6A09961C354991CD653B274DC8C2023662CB@ussdixms03.am.sony.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Geoff,

> Seems like this in needed too...  Untested.

Looks good but the patch appears to be line wrapped in a few places.

Anton

> Change the scope of some pSeries routines now called through
> ppc_md to static.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> --
> Index: a/arch/powerpc/platforms/pseries/lpar.c
> ===================================================================
> --- a.orig/arch/powerpc/platforms/pseries/lpar.c	2006-07-18
> 12:37:47.000000000 -0700
> +++ a/arch/powerpc/platforms/pseries/lpar.c	2006-07-20
> 05:18:59.000000000 -0700
> @@ -268,7 +268,7 @@
>  				cpu, hwcpu, vpa, ret);
>  }
>  
> -long pSeries_lpar_hpte_insert(unsigned long hpte_group,
> +static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
>   			      unsigned long va, unsigned long pa,
>   			      unsigned long rflags, unsigned long
> vflags,
>   			      int psize)
> @@ -494,7 +494,7 @@
>   * Take a spinlock around flushes to avoid bouncing the hypervisor
> tlbie
>   * lock.
>   */
> -void pSeries_lpar_flush_hash_range(unsigned long number, int local)
> +static void pSeries_lpar_flush_hash_range(unsigned long number, int
> local)
>  {
>  	int i;
>  	unsigned long flags = 0;
