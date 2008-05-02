Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D16D2DDF34
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 23:41:35 +1000 (EST)
Message-Id: <68FE3962-84B3-4A5A-A64A-3FD1B7F6B4E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <20862df61b024849f55dbd54de7cfb8f@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Fri, 2 May 2008 08:41:27 -0500
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<bfc75e2dc32ba86b93751cb21df97e56@kernel.crashing.org>
	<BC3385F6-8403-446C-BC04-4DA811CFE96A@kernel.crashing.org>
	<20862df61b024849f55dbd54de7cfb8f@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 8:37 AM, Segher Boessenkool wrote:

>>> Why can't we link with libgcc, instead?
>>
>> we possibly could, the problem is knowing the path of libgcc to  
>> link with.
>
> gcc -print-libgcc-file-name

It wasn't clear if we used a multilib toolchain if we always get the  
proper libgcc since we are building bootwrappers for all kinda of  
variants.  (e500, 40x, 6xx, etc.).  My patch seemed the least painful  
solution to me.

I assume there is a reason we don't link libgcc w/the kernel.

>>  This seemed easier to me than the makefile headaches to ensure  
>> that we get that right.
>
> Ah come on, make syntax is fun!

Yes, yes it is ;)

- k
