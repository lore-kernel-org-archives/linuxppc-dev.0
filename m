Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C40ADE770
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 00:31:32 +1000 (EST)
Message-Id: <256CA345-23C6-4851-B769-7A3EFAE0BCEA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1214991302.7436.7.camel@localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2 1/2] powerpc: Fix building of feature-fixup tests on
	ppc32
Date: Wed, 2 Jul 2008 09:31:22 -0500
References: <Pine.LNX.4.64.0807011015390.20129@blarg.am.freescale.net>
	<1214991302.7436.7.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 2, 2008, at 4:35 AM, Michael Ellerman wrote:

> On Tue, 2008-07-01 at 10:16 -0500, Kumar Gala wrote:
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
> Sorry, I definitely built (and booted) a 32-bit config, so I'm not  
> sure
> how I missed that. What toolchain are you using?

gcc-4.3.0 from fedora 9 on a G5.

- k
