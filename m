Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2AF30B6F71
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 06:03:34 +1000 (EST)
Date: Thu, 7 Apr 2011 14:48:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/book3e: Fix CPU feature handling on 64-bit e5500
Message-ID: <20110407144819.333dc3f1@schlenkerla.am.freescale.net>
In-Reply-To: <7597043B-4C16-47F7-8AF7-111A5815545E@kernel.crashing.org>
References: <1302092943-10586-1-git-send-email-galak@kernel.crashing.org>
	<20110406130257.2d31beaa@schlenkerla.am.freescale.net>
	<7597043B-4C16-47F7-8AF7-111A5815545E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 7 Apr 2011 14:38:57 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Apr 6, 2011, at 1:02 PM, Scott Wood wrote:
> 
> > On Wed, 6 Apr 2011 07:29:03 -0500
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> > 
> >> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> >> index be3cdf9..9028a9e 100644
> >> --- a/arch/powerpc/include/asm/cputable.h
> >> +++ b/arch/powerpc/include/asm/cputable.h
> >> @@ -386,6 +386,10 @@ extern const char *powerpc_base_platform;
> >> 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
> >> 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
> >> 	    CPU_FTR_DBELL)
> >> +#define CPU_FTRS_E5500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
> >> +	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
> > 
> > E5500 cannot doze or nap in the way meant by existing code (MSR[WE]).
> 
> Should I drop them for e500mc as well?

Yes.

-Scott
