Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85202DDE03
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 09:31:53 +1000 (EST)
In-Reply-To: <1214991302.7436.7.camel@localhost>
References: <Pine.LNX.4.64.0807011015390.20129@blarg.am.freescale.net>
	<1214991302.7436.7.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1df9f1fb75467e62b22e6f1c4ffc9c4e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] powerpc: Fix building of feature-fixup tests on
	ppc32
Date: Thu, 3 Jul 2008 01:31:13 +0200
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> We need to use PPC_LCMPI otherwise we get compile errors like:
>>
>> arch/powerpc/lib/feature-fixups-test.S: Assembler messages:
>> arch/powerpc/lib/feature-fixups-test.S:142: Error: Unrecognized 
>> opcode: `cmpdi'
>> arch/powerpc/lib/feature-fixups-test.S:149: Error: Unrecognized 
>> opcode: `cmpdi'
>> arch/powerpc/lib/feature-fixups-test.S:164: Error: Unrecognized 
>> opcode: `cmpdi'
>
> Sorry, I definitely built (and booted) a 32-bit config, so I'm not sure
> how I missed that. What toolchain are you using?

It's more interesting to hear what version of GCC and GAS _you_ are
using :-)

Does it allow 64-bit-only opcodes with -a32?  Does the build system
somehow not pass -a32 for you?


Segher
