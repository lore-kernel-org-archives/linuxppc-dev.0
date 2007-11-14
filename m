Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 067A4DDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 21:05:09 +1100 (EST)
Subject: Re: Kernel locks up after calling kernel_execve()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20071114093939.297890@gmx.net>
References: <20071108214723.135260@gmx.net>
	<1194564017.6561.21.camel@pasglop> <20071109074155.266120@gmx.net>
	<1194594629.6561.34.camel@pasglop>  <20071110171130.254580@gmx.net>
	<1194753340.21340.24.camel@pasglop>  <20071113212320.85840@gmx.net>
	<1194990218.28865.1.camel@pasglop>  <20071113220655.85840@gmx.net>
	<1194997072.28865.5.camel@pasglop>  <20071114093939.297890@gmx.net>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 21:04:57 +1100
Message-Id: <1195034697.28865.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-14 at 10:39 +0100, Gerhard Pircher wrote:
> Yeah, the northbridge hates the M bit! Thus the AmigaOne platform code
> masks out the CPU_FTR_NEED_COHERENT flag and disables the L2 cache
> prefetch engines (I don't care about the performance loss).
> I couldn't find any other code that sets the M bit, except for huge
> TLB
> page support, but isn't that only for PPC64?

Right, it's only 64 bits. You've double checked nothing broke the M bit
thing ? In which case, I don't know what else...

Ben.
