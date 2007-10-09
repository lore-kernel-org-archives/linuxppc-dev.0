Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6F4EDDF16
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 23:30:31 +1000 (EST)
In-Reply-To: <fa686aa40710082100h29c1d2a8hf939ca3306562fac@mail.gmail.com>
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<fa686aa40710082100h29c1d2a8hf939ca3306562fac@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E83F8EDA-95EF-4116-A214-D008BA70135D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Build failure on treeboot-walnut.c
Date: Tue, 9 Oct 2007 08:30:37 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 8, 2007, at 11:00 PM, Grant Likely wrote:

> On 10/8/07, Timur Tabi <timur@freescale.com> wrote:
>> Looks like the problem is back:
>>
>>    BOOTCC  arch/powerpc/boot/treeboot-walnut.o
>> Assembler messages:
>> Error: Internal assembler error for instruction icbt
>> Internal error, aborting at
>> /tmp/crosstool/crosstool-0.42/build/powerpc-unknown-linux-gnu/ 
>> gcc-4.0.2_e300-enabled-glibc-2.3.6/binutils-2.16.1-complete/gas/ 
>> config/tc-ppc.c
>> line 1314 in ppc_setup_opcodes
>> Please report this bug.
>> make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
>> make: *** [uImage] Error 2
>
> No; this is something different.  The assember itself is failing
> internally.  What version of binutils are you running?
>

2.61.1 if we believe his path :)

the assembler is failing because 'icbt' has several possible  
different instruction encodings and I'm guessing he's getting a  
conflict set.

What's the actual compile line?  Want to see the flags to assembler  
of -Wa to the compiler.

- k
