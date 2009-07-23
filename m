Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 03D38B7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 08:10:23 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63D20DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 08:10:21 +1000 (EST)
Subject: Re: [PATCH 0/20] powerpc: base 64-bit Book3E processor support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <94483336-7714-4713-AB1C-2AAAA9BBB638@kernel.crashing.org>
References: <1248328938.3367.46.camel@pasglop>
	<94483336-7714-4713-AB1C-2AAAA9BBB638@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 24 Jul 2009 08:10:15 +1000
Message-Id: <1248387015.25467.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-23 at 09:42 -0500, Kumar Gala wrote:
> >
> > The intend is to merge these in 2.6.32. They rely on pretty much
> > all the other patches I've been posting lately including the
> > generic changes to add the virtual address argument to pte_free_tlb.
> >
> 
> Are these in a git tree/branch.  Makes it a bit easier to test out on  
> FSL booke-32 to make sure we didn't break anything.

Plan is to stick them in my -test branch for a few days before they hit
-next, I just didn't have time to finish that yesterday, hopefully will
do today along with addressing a few comments already done about them.

Cheers,
Ben.
