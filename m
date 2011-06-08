Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [RFC][V3] bluegene: add entry to cpu table
In-reply-to: <1307494181.2874.214.camel@pasglop>
References: <1307472447-1656-1-git-send-email-ericvh@gmail.com>
	<1307494181.2874.214.camel@pasglop>
Date: Wed, 08 Jun 2011 15:37:58 +1000
Message-ID: <7945.1307511478@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Create an entry for the BG/P chips, include bits to accomodate
> > the double fp2 fpu and the special MMU considerations like L1
> > writethrough.
> > 
> > RFC Note: this patch fails scripts/checkpatch.pl because I
> > matched coding style of the surrounding existing code.  Would
> > you rather have something checkpatch.pl clean or something
> > which is consistent with the surrounding code style?
> 
> Stay consistent. You're welcome to my next checkpatch burning
> ceremony :-)

I'll make t-shirts for us!

> >  #define PPC_FEATURE_POWER6_EXT		0x00000200
> >  #define PPC_FEATURE_ARCH_2_06		0x00000100
> >  #define PPC_FEATURE_HAS_VSX		0x00000080
> > +#define PPC_FEATURE_HAS_FPU_FP2		0x00000040
> 
> Any chance for a better name ?

I've painted this particular bike shed with Eric already :-)

It's an extension to the FPU called FP2
(https://wiki.alcf.anl.gov/images/d/d9/PPC440_FP2_arch.pdf).  
So PPC_FEATURE_HAS_FPU -> PPC_FEATURE_HAS_FPU_FP2.

I think the name is right as he has it.

Mikey
