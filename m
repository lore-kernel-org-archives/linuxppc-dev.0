Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17C1EDDDFF
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 22:55:47 +1000 (EST)
Message-Id: <C5D46884-D1BC-4E00-851B-7D13D150F837@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <b5c96a65499b27f0505523fb5b9dfae98a585ed1.1238991483.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
Date: Mon, 6 Apr 2009 07:55:35 -0500
References: <b5c96a65499b27f0505523fb5b9dfae98a585ed1.1238991483.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 5, 2009, at 11:18 PM, Michael Ellerman wrote:

> diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/ 
> Makefile
> index 0c16ab9..dcb2148 100644
> --- a/arch/powerpc/math-emu/Makefile
> +++ b/arch/powerpc/math-emu/Makefile
> @@ -1,4 +1,8 @@
>
> +ifeq ($(CONFIG_PPC_WERROR),y)
> +EXTRA_CFLAGS += -Werror
> +endif
> +
> obj-$(CONFIG_MATH_EMULATION)	+= fabs.o fadd.o fadds.o fcmpo.o  
> fcmpu.o \
> 					fctiw.o fctiwz.o fdiv.o fdivs.o \
> 					fmadd.o fmadds.o fmsub.o fmsubs.o \

We explicitly build math-emu with -w to not see the warnings from it.

- k
