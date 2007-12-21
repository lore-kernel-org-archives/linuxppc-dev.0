Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D02A9DDE1F
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:16:44 +1100 (EST)
Subject: Re: [PATCH 1/21] [POWERPC] Reworking machine check handling and
	Fix 440/440A
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071221060136.611eb899@zod.rchland.ibm.com>
References: <20071221043925.42B40DDE30@ozlabs.org>
	<20071221060136.611eb899@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 22 Dec 2007 08:16:23 +1100
Message-Id: <1198271783.6737.2.camel@pasglop>
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


On Fri, 2007-12-21 at 06:01 -0600, Josh Boyer wrote:
> On Fri, 21 Dec 2007 15:39:21 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> 
> > Index: linux-merge/include/asm-ppc/reg_booke.h
> > ===================================================================
> > --- linux-merge.orig/include/asm-ppc/reg_booke.h	2007-09-28 11:42:10.000000000 +1000
> > +++ linux-merge/include/asm-ppc/reg_booke.h	2007-12-20 11:35:40.000000000 +1100
> > @@ -207,7 +207,7 @@
> >  #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
> > 
> >  /* Bit definitions for the MCSR. */
> > -#ifdef CONFIG_440A
> > +#ifdef CONFIG_44x
> 
> Should be #ifdef CONFIG_4xx as I pointed out last time.  I'll fix it
> when I commit.

Ah weird, I though I fixed it... I must have fixed powerpc and not ppc.

Ben.
