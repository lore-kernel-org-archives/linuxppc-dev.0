Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DE99DDF99
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 23:38:06 +1000 (EST)
In-Reply-To: <BC3385F6-8403-446C-BC04-4DA811CFE96A@kernel.crashing.org>
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<bfc75e2dc32ba86b93751cb21df97e56@kernel.crashing.org>
	<BC3385F6-8403-446C-BC04-4DA811CFE96A@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <20862df61b024849f55dbd54de7cfb8f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Fri, 2 May 2008 15:37:54 +0200
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
> we possibly could, the problem is knowing the path of libgcc to link 
> with.

gcc -print-libgcc-file-name

>   This seemed easier to me than the makefile headaches to ensure that 
> we get that right.

Ah come on, make syntax is fun!


Segher
