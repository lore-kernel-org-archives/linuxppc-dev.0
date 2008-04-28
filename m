Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4DBC7DDE0D
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 16:10:57 +1000 (EST)
Message-Id: <CD813903-3BD8-4683-9A74-9C8866F1B2F4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18453.26718.402204.95133@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Add IRQSTACKS support on ppc32
Date: Mon, 28 Apr 2008 01:10:51 -0500
References: <Pine.LNX.4.64.0804240814280.29846@blarg.am.freescale.net>
	<18453.24013.647603.723185@cargo.ozlabs.ibm.com>
	<D84B894B-B6E8-47FD-97CE-CACDE7835B78@kernel.crashing.org>
	<18453.26718.402204.95133@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2008, at 1:02 AM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>>> Mostly looks great.  One minor nit is that this ifdef could  
>>> disappear
>>> entirely now:
>>
>> How do you figure?  If we want to maintain it as a config option (for
>> at least 2.6.26) we  either need this ifdef or a dummy  
>> irq_ctx_init().
>
> In include/asm-powerpc/irq.h we already have a dummy definition:
>
> #ifdef CONFIG_IRQSTACKS
>
> ...
>
> #else
> #define irq_ctx_init()
>
> #endif /* CONFIG_IRQSTACKS */

Missed that.  Will drop the ifdef in irq.c and repost.

- k
