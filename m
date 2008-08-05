Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8A4EDDEEE
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 18:11:39 +1000 (EST)
Subject: Re: [PATCH] powerpc/mm: Fix attribute confusion with
	htab_bolt_mapping()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080805172803.1c556b37.sfr@canb.auug.org.au>
References: <20080805062012.2A161DDE1A@ozlabs.org>
	<20080805172803.1c556b37.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 18:11:27 +1000
Message-Id: <1217923887.24157.166.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-08-05 at 17:28 +1000, Stephen Rothwell wrote:
> Hi Ben,
> 
> Just a trivial note ..
> 
> On Tue, 05 Aug 2008 16:19:56 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > +++ linux-work/arch/powerpc/mm/hash_utils_64.c	2008-08-05 16:09:47.000000000 +1000
> > @@ -18,7 +18,7 @@
> >   * 2 of the License, or (at your option) any later version.
> >   */
> >  
> > -#undef DEBUG
> > +#define DEBUG
> 
> You will turn this off again before it goes into Paulus' tree, right? :-)

Ahah ! Good catch :-)

Yup, I will. I forgot to add RFC in fact, as this is what that patch is
at least for today. I need to run a few more tests tomorrow before
paulus merges it.

Cheers,
Ben.
