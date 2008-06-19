Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 6/9] powerpc: Add VSX CPU feature 
In-reply-to: <1213858308.26255.1390.camel@pmac.infradead.org> 
References: <20080618004734.1A41370297@localhost.localdomain>
	<1213858308.26255.1390.camel@pmac.infradead.org>
Date: Thu, 19 Jun 2008 17:00:47 +1000
Message-ID: <4751.1213858847@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wed, 2008-06-18 at 10:47 +1000, Michael Neuling wrote:
> >         {"ibm,vmx", 1, CPU_FTR_ALTIVEC, PPC_FEATURE_HAS_ALTIVEC},
> >  #endif /* CONFIG_ALTIVEC */
> > +#ifdef CONFIG_VSX
> > +       {"ibm,vmx", 2, CPU_FTR_VSX, PPC_FEATURE_HAS_VSX},
> > +#endif /* CONFIG_VSX */
> 
> Should that be "ibm,vsx"?

Nope "ibm,vmx" == 2 is correct for VSX.

You're not the first to think it looks wrong, so I should add a
comment.  

Mikey
