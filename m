Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45582DDED4
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 07:28:41 +1000 (EST)
Message-Id: <3B083683-CB6E-4F1D-87EF-BBFA7D491271@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <56cafb8cfeb954984d6e400c3de789b8@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Fri, 2 May 2008 16:28:36 -0500
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<bfc75e2dc32ba86b93751cb21df97e56@kernel.crashing.org>
	<8CB3566C-F433-4457-906D-247BBB8D5505@kernel.crashing.org>
	<56cafb8cfeb954984d6e400c3de789b8@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 12:11 PM, Segher Boessenkool wrote:

>>> Why can't we link with libgcc, instead?
>>
>> Do you have or can you generate a ppc64 toolchain with this patch  
>> in it?
>
> I'm not sure what you mean.

Sorry, I meant the gcc patch.  I'm not sure if this has been committed  
to FSF head or not.

> I build GCC TOT toolchains sort-of daily, and build the kernel
> with it (all architectures).  I don't build any 4xx config though,
> maybe I should.

I'm guessing you haven't seen this issue yet.

- k
