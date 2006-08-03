Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail54-fra-R.bigfish.com (mail-fra.bigfish.com [62.209.45.166])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C84AD67B63
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 07:17:38 +1000 (EST)
Message-ID: <44D267EA.8050103@am.sony.com>
Date: Thu, 03 Aug 2006 14:17:30 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] clean up pseries hcall interfaces
References: <591B6A09961C354991CD653B274DC8C2023662CB@ussdixms03.am.sony.com>	<20060725144124.GA3769@krispykreme>	<44C68544.9000609@am.sony.com>
	<17617.30304.366738.986854@cargo.ozlabs.ibm.com>
In-Reply-To: <17617.30304.366738.986854@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Geoff Levand writes:
> 
>> Change the scope of some pSeries routines now called through
>> ppc_md to static.
> 
> With this I get:
> 
>   CC      arch/powerpc/platforms/pseries/lpar.o
> /home/paulus/kernel/powerpc/arch/powerpc/platforms/pseries/lpar.c:273: error: static declaration of ‘pSeries_lpar_hpte_insert’ follows non-static declaration
> include2/asm/mmu.h:254: error: previous declaration of ‘pSeries_lpar_hpte_insert’ was here
> make[3]: *** [arch/powerpc/platforms/pseries/lpar.o] Error 1

OK, thanks for checking it.  As I mentioned in my original
mail, it just looked like there could be some cleanup done,
but I didn't test it.  I'll take a look at it some more and
see if I can make a proper re-work.

-Geoff
