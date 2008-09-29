Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1311DDED4
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 18:54:27 +1000 (EST)
Subject: Re: Fix PCI in Holly device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080925122241.GC2243@yoda.jdub.homelinux.org>
References: <20080925023904.GC15169@yookeroo.seuss>
	<20080925081129.7f882085@zod.rchland.ibm.com>
	<20080925122241.GC2243@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Mon, 29 Sep 2008 18:53:03 +1000
Message-Id: <1222678383.7807.97.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >
> >Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> >
> >Paul, I can include this in my 'next' branch if you aren't opposed.
> >I'll have another set of patches going in there today/tomorrow.
> 
> Er... on second thought, this actually fixes a regression on Holly.  So
> I'll amend my offer to put it in my 'next' branch to be contingent on you
> not wanting to get it into 2.6.27 this late.

I've picked it up, I need to check a thing or two and I'll send patches
for .27 to Linus tomorrow (Paulus is on vacation for a week). With a bit
of luck he won't have closed .27 before that :-)

Cheers
Ben.
