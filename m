Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17995.58640.165251.501487@cargo.ozlabs.ibm.com>
Date: Thu, 17 May 2007 15:16:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] fix non HUGETLB_PAGE build warning
In-Reply-To: <20070514141136.39a76d32.sfr@canb.auug.org.au>
References: <20070514141136.39a76d32.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

> arch/powerpc/mm/mmu_context_64.c: In function 'init_new_context':
> arch/powerpc/mm/mmu_context_64.c:31: warning: unused variable 'new_context'

> +#ifdef CONFIG_PPC_MM_SLICES
>  	int new_context = (mm->context.id == 0);
> +#endif

Could we use __unused to suppress the warning instead?

Paul.
