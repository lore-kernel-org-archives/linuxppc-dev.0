Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06FA61A0A9C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 07:15:06 +1000 (AEST)
Message-ID: <1433970898.1495.60.camel@twins>
Subject: Re: question on FSL_EMB perf
From: Peter Zijlstra <peterz@infradead.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Date: Wed, 10 Jun 2015 23:14:58 +0200
In-Reply-To: <1433967236.2477.146.camel@freescale.com>
References: <20150610114126.GN19282@twins.programming.kicks-ass.net>
 <1433963830.2477.136.camel@freescale.com> <1433964454.1495.58.camel@twins>
 <1433967236.2477.146.camel@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-06-10 at 15:13 -0500, Scott Wood wrote:

> What sort of "nesting nonsense" would we get on ppc32?  I wasn't=20
> trying to say that the pseudo-NMIs didn't count -- I was pointing out=20
> that we don't even have that on ppc32.

Oh, I was not aware ppc32 did not have that.

> > # git grep nmi_enter arch/powerpc/
> > arch/powerpc/perf/core-book3s.c:                nmi_enter();
> > arch/powerpc/perf/core-fsl-emb.c:               nmi_enter();
>=20
> nmi_enter() only gets called when perf_intr_is_nmi() returns non-zero,=
=20
> which only happens on ppc64.

ok, so fsl-emb is ppc32 and ppc64, not confusing at all this stuff.
