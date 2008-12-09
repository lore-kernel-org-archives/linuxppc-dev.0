Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C0BD3DDF18
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 00:17:39 +1100 (EST)
Message-Id: <6CFA99B4-6757-414F-B272-2B6925682593@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1228714789.103940.266501677728.qpush@grosgo>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 0/9] powerpc: Preliminary work to enable SMP BookE
Date: Tue, 9 Dec 2008 07:17:33 -0600
References: <1228714789.103940.266501677728.qpush@grosgo>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2008, at 11:39 PM, Benjamin Herrenschmidt wrote:

> This series of patches is aimed at supporting SMP on non-hash
> based processors. It consists of a rework of the MMU context
> management and TLB management, clearly splitting hash32, hash64
> and nohash in both cases, adding SMP safe context handling and
> some basic SMP TLB management.
>
> There is room for improvements, such as implementing lazy TLB
> flushing on processors without invalidate-by-PID support HW,
> some better IPI mechanism, support for variable sizes PID,
> lock less fast path in the MMU context switch, etc...
> but it should basically work.
>
> There are some semingly unrelated patches in the pile as they
> are dependencies of the main ones so I'm including them in.

You'll be happy to know these patches at least boot on real 85xx SMP HW.

- k
