Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D50EDDF2B
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 03:06:02 +1100 (EST)
Message-Id: <CFACC97C-D525-4E64-BB8D-79A499B9F915@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1229663599.904385.502157196243.qpush@grosgo>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 0/10] powerpc: Preliminary work to enable SMP BookE (v3)
Date: Fri, 19 Dec 2008 10:05:26 -0600
References: <1229663599.904385.502157196243.qpush@grosgo>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 18, 2008, at 11:13 PM, Benjamin Herrenschmidt wrote:

> This series of patches is aimed at supporting SMP on non-hash
> based processors. It consists of a rework of the MMU context
> management and TLB management, clearly splitting hash32, hash64
> and nohash in both cases, adding SMP safe context handling and
> some basic SMP TLB management.
>
> There is room for improvements, such as implementing lazy TLB
> flushing on processors without invalidate-by-PID support HW,
> some better IPI mechanism, lock less fast path in the MMU context
> switch, etc... but it should basically work.
>
> This version addresses the issues raised about some of the patches
> in the previous batch, removes the ones that were already merged
> in -next and and rebases the remaining ones when needed.
>

All patches

Acked-by: Kumar Gala <galak@kernel.crashing.org>

Please put these in powerpc/next and I can work up some 85xx SMP  
support on top of them.

- k
