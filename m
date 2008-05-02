Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45C39DDEF4
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 03:11:32 +1000 (EST)
In-Reply-To: <8CB3566C-F433-4457-906D-247BBB8D5505@kernel.crashing.org>
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<bfc75e2dc32ba86b93751cb21df97e56@kernel.crashing.org>
	<8CB3566C-F433-4457-906D-247BBB8D5505@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <56cafb8cfeb954984d6e400c3de789b8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Fri, 2 May 2008 19:11:23 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Why can't we link with libgcc, instead?
>
> Do you have or can you generate a ppc64 toolchain with this patch in 
> it?

I'm not sure what you mean.

I build GCC TOT toolchains sort-of daily, and build the kernel
with it (all architectures).  I don't build any 4xx config though,
maybe I should.


Segher
