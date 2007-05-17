Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED15EDDDE9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 21:47:45 +1000 (EST)
In-Reply-To: <20070517112704.c4ec9330.sfr@canb.auug.org.au>
References: <11793283363025-git-send-email-segher@kernel.crashing.org>
	<20070517112704.c4ec9330.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4d3bc62738853bc99dca2f21feef15e4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix VDSO compile warning
Date: Thu, 17 May 2007 13:47:22 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Maybe the type should have been char[] instead of __u8[]
>> in the first place, but this will do.
>
> What warning do you get?

Oh sorry, should have mentioned that:

arch/powerpc/kernel/vdso.c: In function 'vdso_init':
arch/powerpc/kernel/vdso.c:673: warning: passing argument
	1 of 'strcpy' from incompatible pointer type

> What compiler version?

GCC mainline of two days ago.


Segher
