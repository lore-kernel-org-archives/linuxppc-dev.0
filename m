Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E878DB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 00:42:48 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16942DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 00:42:47 +1000 (EST)
Message-Id: <94483336-7714-4713-AB1C-2AAAA9BBB638@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1248328938.3367.46.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 0/20] powerpc: base 64-bit Book3E processor support
Date: Thu, 23 Jul 2009 09:42:41 -0500
References: <1248328938.3367.46.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 23, 2009, at 1:02 AM, Benjamin Herrenschmidt wrote:

> Here is a series of patches that implement some basic support
> for 64-bit Book3E processors that comply to architecture 2.06.
>
> There is no specific processor announced yet. The patches make
> some shortcut which means they currently rely on an implementation
> that supports MMU v2 with support for the "HES" feature (HW entry
> select) and with support for the "TLB reservation" feature. They
> also assume a single unified TLB array. I shouldn't be very hard
> to implement support for other variants of the architecture on
> top of this though.
>
> The current set of patch has no proper support yet for hugetlb,
> nor for "special" interrupt levels (debug, critical and machine
> check). Some minimal support for debug/critical levels is provided
> specifically for the "Debug" interrupt (single step etc...) only
> when it occurs from within user space code.
>
> The intend is to merge these in 2.6.32. They rely on pretty much
> all the other patches I've been posting lately including the
> generic changes to add the virtual address argument to pte_free_tlb.
>

Are these in a git tree/branch.  Makes it a bit easier to test out on  
FSL booke-32 to make sure we didn't break anything.

- k
