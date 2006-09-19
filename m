Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B7D7C67B6C
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 00:55:06 +1000 (EST)
Date: Tue, 19 Sep 2006 18:55:17 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Amy Fong <amy.fong@windriver.com>
Subject: Re: [PATCH] fix error in cpm2
Message-ID: <20060919185517.34ecea4a@vitb.ru.mvista.com>
In-Reply-To: <20060919030625.GA24944@lucciola.windriver.com>
References: <20060919030625.GA24944@lucciola.windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 Sep 2006 23:06:25 -0400
Amy Fong <amy.fong@windriver.com> wrote:

> The following patch fixes a typo in cpm2.h resulting in a compile error.
> 
> Signed-off-by: Amy Fong <amy.fong@windriver.com>
> 
> Index: linux-2.6.18-rc6/include/asm-ppc/cpm2.h
> ===================================================================
> --- linux-2.6.18-rc6.orig/include/asm-ppc/cpm2.h
> +++ linux-2.6.18-rc6/include/asm-ppc/cpm2.h
> @@ -1186,7 +1186,7 @@
>  #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
>  #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
>  #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
> -#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
> +#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
>  
>  #endif /* __CPM2__ */
>  #endif /* __KERNEL__ */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
Well, I have this hunk in

[PATCH 3/7] POWERPC: Move generic cpm2 stuff to powerpc
already...

Paul, does it make sense to extract and re-send this specific fix?
I think it will be OK for this to appear next major merge...
-- 
Sincerely, 
Vitaly
