Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F651DDF3F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 07:49:32 +1100 (EST)
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <49871D3E.80809@gefanuc.com>
References: <4982F311.4050507@gefanuc.com>
	<F764D461-8EFB-4B31-ABFC-ECBB7A3FBA01@kernel.crashing.org>
	<9B0CCADB-C891-42B2-BE94-0927B5715A00@kernel.crashing.org>
	<4986BEB9.3030606@gefanuc.com>
	<E00697F4-1313-49C2-9F8A-79FC9E511022@kernel.crashing.org>
	<498718B6.3030307@gefanuc.com>
	<D06DAB0F-1477-4CA6-A06D-0F7B62939C86@kernel.crashing.org>
	<49871D3E.80809@gefanuc.com>
Content-Type: text/plain
Date: Tue, 03 Feb 2009 07:49:13 +1100
Message-Id: <1233607753.18767.103.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >> commit 64b3d0e8122b422e879b23d42f9e0e8efbbf9744
> >> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>
> >>   powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED
> >>
> >> I tried reverting it, but as I had kinda thought, that really didn't 
> >> help.
> >>
> >> I'm just recompiling to check that I didn't screw-up during the 
> >> bisection.
> > 

Is this a chip that must not have M set ? Or something else ? You guys
have to help if you CC me, I have about 0 idea what a MPC8661d is :-)

Also, does 4c456a67f501b8b15542c7c21c28812bf88f484b help ?
> 
Cheers,
Ben.
