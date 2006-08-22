Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5620267BDF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 20:02:58 +1000 (EST)
Date: Tue, 22 Aug 2006 14:02:38 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] POWERPC: move the generic cpm2 stuff to the powerpc
Message-ID: <20060822140238.6b40687e@localhost.localdomain>
In-Reply-To: <44DE1FA1.2040604@ru.mvista.com>
References: <20060812000655.6186.42738.stgit@localhost.localdomain>
	<20060812001013.6186.41337.stgit@localhost.localdomain>
	<44DE1FA1.2040604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 12 Aug 2006 22:36:17 +0400
Sergei Shtylyov wrote:

> Hello.
> 
> Vitaly Bordug wrote:
> > This moves the cpm2 common code and PIC stuff to the powerpc. Most
> > of the files were just copied from ppc/, with minor tuning to make
> > it compile, and, subsequently, work.
> > 
> > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> 
> [...]
> 
> > diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
> > index f6a7ff0..876974e 100644
> > --- a/include/asm-ppc/cpm2.h
> > +++ b/include/asm-ppc/cpm2.h
> [...]
> > @@ -1186,7 +1190,7 @@ #define PC3_DIRC1	(PC3_TXDAT)
> >  #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
> >  #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
> >  #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
> > -#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
> > +#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
> >  
> >  #endif /* __CPM2__ */
> >  #endif /* __KERNEL__ */
> 
>     Alas, this last hunk doesn't apply to powerpc.git. Shouldn't it
> be in some other patch instead?

This whole patch series depends on the fs_enet PALification series, that 
is accepted to netdev tree at least, according to the last mail from Andrew Morton.

Hence, it will be auto-fixed shortly. Next time I'll submit the preceding stuff
as well to prevent confusion.
> 
> WBR, Sergei
> 
> 
