Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 006F467BC9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 00:01:09 +1000 (EST)
Date: Thu, 28 Sep 2006 18:01:26 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc: fix build break
Message-ID: <20060928180126.0e5cdac0@vitb.ru.mvista.com>
In-Reply-To: <437E571F-79E3-4A2D-ADD1-83953022B053@kernel.crashing.org>
References: <20060927235717.40cbd0e7@pb15>
	<437E571F-79E3-4A2D-ADD1-83953022B053@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Sep 2006 08:41:57 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Sep 27, 2006, at 11:57 PM, Olof Johansson wrote:
> 
> > Fix build break for some of the ARCH=ppc defconfigs
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> This breakage exists in 2.6.18 as well?  If so would be good to send  
> this patch to -stable if its not already there.
> 

This was addressed in my series, then by Amy Wang, and below :)
Hence I expect it to appear in powerpc.git very shortly, but for -stable it makes sense.


Thanks,
-Vitaly


> - k
> 
> >
> > ---
> >
> > This was introduced by:
> >
> > [PATCH] ppc32: board-specific part of fs_enet update
> >
> >
> > Index: linux-2.6/include/asm-ppc/cpm2.h
> > ===================================================================
> > --- linux-2.6.orig/include/asm-ppc/cpm2.h
> > +++ linux-2.6/include/asm-ppc/cpm2.h
> > @@ -1186,7 +1186,7 @@ typedef struct im_idma {
> >  #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
> >  #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
> >  #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
> > -#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
> > +#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
> >
> >  #endif /* __CPM2__ */
> >  #endif /* __KERNEL__ */
> 
> 


-- 
Sincerely, 
Vitaly
