Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6141CDDE29
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 09:46:08 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix 44x Machine Check handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6612E7C6-C570-4748-BCEE-AC6733C0BB14@kernel.crashing.org>
References: <20071116072149.350ADDDDF4@ozlabs.org>
	<6612E7C6-C570-4748-BCEE-AC6733C0BB14@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 17 Nov 2007 09:21:41 +1100
Message-Id: <1195251702.28865.182.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Index: linux-work/include/asm-powerpc/cputable.h
> > ===================================================================
> > --- linux-work.orig/include/asm-powerpc/cputable.h	2007-11-16  
> > 16:14:29.000000000 +1100
> > +++ linux-work/include/asm-powerpc/cputable.h	2007-11-16  
> > 16:19:35.000000000 +1100
> > @@ -138,6 +138,7 @@ extern void do_feature_fixups(unsigned l
> > #define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x0000000000800000)
> > #define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x0000000001000000)
> > #define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
> > +#define CPU_FTR_440A			ASM_CONST(0x0000000004000000)
> 
> Can we be more specific about what this feature really means.
> 
> How about something like CPU_FTR_ENH_MCHCK or something like that.

Did that at first, then figured out that I indeed had 2 core manuals one
of them being labelled "A"... I'm trying to figure out what other
differences they may have to see whether I should stick to that CPU
feature or just remove it completely and do as Olof suggested.

Ben.
