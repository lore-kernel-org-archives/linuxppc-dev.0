Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9E4C1A0AA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 07:28:20 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0103.outbound.protection.outlook.com [207.46.100.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC16E140293
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 07:28:19 +1000 (AEST)
Message-ID: <1433971691.2477.150.camel@freescale.com>
Subject: Re: question on FSL_EMB perf
From: Scott Wood <scottwood@freescale.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Date: Wed, 10 Jun 2015 16:28:11 -0500
In-Reply-To: <1433970898.1495.60.camel@twins>
References: <20150610114126.GN19282@twins.programming.kicks-ass.net>
 <1433963830.2477.136.camel@freescale.com> <1433964454.1495.58.camel@twins>
 <1433967236.2477.146.camel@freescale.com> <1433970898.1495.60.camel@twins>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-10 at 23:14 +0200, Peter Zijlstra wrote:
> On Wed, 2015-06-10 at 15:13 -0500, Scott Wood wrote:
> 
> > What sort of "nesting nonsense" would we get on ppc32?  I wasn't 
> > trying to say that the pseudo-NMIs didn't count -- I was pointing 
> > out 
> > that we don't even have that on ppc32.
> 
> Oh, I was not aware ppc32 did not have that.
> 
> > > # git grep nmi_enter arch/powerpc/
> > > arch/powerpc/perf/core-book3s.c:                nmi_enter();
> > > arch/powerpc/perf/core-fsl-emb.c:               nmi_enter();
> > 
> > nmi_enter() only gets called when perf_intr_is_nmi() returns non-
> > zero, 
> > which only happens on ppc64.
> 
> ok, so fsl-emb is ppc32 and ppc64, not confusing at all this stuff.

Both drivers can be used on either 32 or 64 bits.

-Scott
