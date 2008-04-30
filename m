Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECFBDDDE0F
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 07:02:07 +1000 (EST)
In-Reply-To: <20080430172254.GA28169@ld0162-tx32.am.freescale.net>
References: <20071023212404.GA30942@loki.buserror.net>
	<Pine.LNX.4.64.0804251454050.6045@axis700.grange>
	<20080428203322.GD15223@ld0162-tx32.am.freescale.net>
	<18454.42926.213374.977098@cargo.ozlabs.ibm.com>
	<20080430172254.GA28169@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2af4cf23ed3fc48c87b50a5f63d868d7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
Date: Wed, 30 Apr 2008 23:01:47 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> 3. The style in all the assembly code is not to have spaces after
>> commas separating instruction operands.
>
> I'll do that if that's what is prefered, but how did that come about as
> the style used?  It's different from what we do in C,

But this isn't C code, it's assembler code.  PowerPC assembler code
(and most other assembler code) doesn't use spaces here usually.

> and adding the
> space helps readability in asm as well...

Many people disagree ;-)

Anyway, it's better to keep a consistent style, whatever that style
is, don't you agree?


Segher
