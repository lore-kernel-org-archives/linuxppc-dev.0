Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78576DDEDD
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 03:15:33 +1000 (EST)
In-Reply-To: <68FE3962-84B3-4A5A-A64A-3FD1B7F6B4E3@kernel.crashing.org>
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<bfc75e2dc32ba86b93751cb21df97e56@kernel.crashing.org>
	<BC3385F6-8403-446C-BC04-4DA811CFE96A@kernel.crashing.org>
	<20862df61b024849f55dbd54de7cfb8f@kernel.crashing.org>
	<68FE3962-84B3-4A5A-A64A-3FD1B7F6B4E3@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fc168238292deeec4612f9fe5ad3e03f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Fri, 2 May 2008 19:15:26 +0200
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

>> gcc -print-libgcc-file-name
>
> It wasn't clear if we used a multilib toolchain if we always get the 
> proper libgcc since we are building bootwrappers for all kinda of 
> variants.  (e500, 40x, 6xx, etc.).

gcc -mthe-options-to-select-some-target -print-libgcc-file-name

> My patch seemed the least painful solution to me.

In the short term, perhaps ;-)

> I assume there is a reason we don't link libgcc w/the kernel.

It's historical, even _if_ there was a valid reason once (and I'm
not so sure about that), who knows if there still is.

Besides, this is not the kernel, this is the bootwrapper, I strongly
doubt libgcc would cause any conflicts here.


Segher
