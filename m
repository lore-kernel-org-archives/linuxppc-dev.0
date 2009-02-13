Return-Path: <rpm@xenomai.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by ozlabs.org (Postfix) with ESMTP id 3ADB1DDEEC
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 21:01:29 +1100 (EST)
Message-ID: <499544EF.6070200@xenomai.org>
Date: Fri, 13 Feb 2009 11:01:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix _PAGE_CHG_MASK
References: <4994A046.2080806@xenomai.org>	 <1234493350.29851.80.camel@pasglop>
	<1234504015.26036.43.camel@pasglop>
In-Reply-To: <1234504015.26036.43.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: rpm@xenomai.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2009-02-13 at 13:49 +1100, Benjamin Herrenschmidt wrote:
> 
>>> diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
>>> index 75dded6..8298afc 100644
>>> --- a/arch/powerpc/include/asm/pgtable-ppc32.h
>>> +++ b/arch/powerpc/include/asm/pgtable-ppc32.h
>>> @@ -428,8 +428,8 @@ extern int icache_44x_need_flush;
>>>  #define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
>>>  #endif
>>>
>>> -#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_SPECIAL)
>>> -
>>> +#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | \
>>> +			 _PAGE_SPECIAL)
>>>
>>>  #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
>>>  			 _PAGE_WRITETHRU | _PAGE_ENDIAN | \
>>>
> 
> BTW. That part of the patch looks bad (ie, the original line isn't what
> is upstream). I've fixed up locally.
>

Sorry for this. I forgot to rebase my patch on mainline.

> Cheers,
> Ben.
> 
> 
> 


-- 
Philippe.
