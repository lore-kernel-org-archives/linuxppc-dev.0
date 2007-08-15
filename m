Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CEB9DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 02:27:29 +1000 (EST)
In-Reply-To: <20070815160254.GA9049@ld0162-tx32.am.freescale.net>
References: <5c9cd53b0708141314o57440c62waffb4cca3f2be0b9@mail.gmail.com>
	<1187124014.32650.80.camel@ld0161-tx32>
	<5c9cd53b0708150657k71531bdbl848375d5d80faf21@mail.gmail.com>
	<20070815160254.GA9049@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A9A39446-A8B0-44D7-ABF4-E9918FCC2843@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: System crash on boot_e500.S
Date: Wed, 15 Aug 2007 11:28:55 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 15, 2007, at 11:02 AM, Scott Wood wrote:

> On Wed, Aug 15, 2007 at 09:57:59AM -0400, mike zheng wrote:
>> Did you done similar work before? Current 2.6 code need many other  
>> files,  I
>> have following errors when I try to use the head_e500.S from 2.6  
>> code:
>>
>>
>> /kernel->   powerpc-linux-gnuspe-gcc -m32 -Wp,-MD,arch/ppc/ 
>> kernel/.entry.o.d
>> -nostdinc -isystem /opt/mtwk/usr/local/gcc-3_4-
>> e500-glibc-2.3.4-dp/powerpc-linux-gnuspe/lib/gcc/powerpc-linux- 
>> gnuspe/3.4.3/include
>> -D__KERNEL__ -Iinclude  -Iarch/ppc -D__ASSEMBLY__ -Iarch/ppc -Wa,- 
>> me500     -c
>> -o arch/ppc/kernel/entry.o arch/ppc/kernel/entry.S
>> arch/ppc/kernel/entry.S: Assembler messages:
>>
>> entry.S:819: Error: unsupported relocation against CSRR0
>> entry.S:820: Error: unsupported relocation against CSRR1
>> entry.S:888: Error: unsupported relocation against MCSRR0
>> entry.S:889: Error: unsupported relocation against MCSRR1
>> entry.S:909: Error: unsupported relocation against CSRR0
>> entry.S:911: Error: unsupported relocation against CSRR1
>
> Try arch/powerpc; arch/ppc is deprecated.

He's trying a 2.4 kernel.

- k
