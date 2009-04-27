Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82BD1DDDB2
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 05:46:28 +1000 (EST)
Message-Id: <3293F2F8-95B7-443C-8284-7F82D30F966B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <439723CB-6615-428B-9A7F-C6CBA5EB7CBE@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/2] powerpc: Add 2.06 tlbie mnemonics
Date: Mon, 27 Apr 2009 14:46:06 -0500
References: <20090424062431.D3803120E7@localhost.localdomain>
	<439723CB-6615-428B-9A7F-C6CBA5EB7CBE@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2009, at 2:31 PM, Kumar Gala wrote:

>
> On Apr 24, 2009, at 1:24 AM, Michael Neuling wrote:
>
>> Index: linux-2.6-ozlabs/arch/powerpc/include/asm/cputable.h
>> ===================================================================
>> --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/cputable.h
>> +++ linux-2.6-ozlabs/arch/powerpc/include/asm/cputable.h
>> @@ -195,6 +195,7 @@ extern const char *powerpc_base_platform
>> #define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
>> #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
>> #define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
>> +#define CPU_FTR_TLBIE_206		LONG_ASM_CONST(0x0100000000000000)
>>
>> #ifndef __ASSEMBLY__
>>
>> @@ -409,7 +410,7 @@ extern const char *powerpc_base_platform
>> 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
>> 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
>> 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
>> -	    CPU_FTR_DSCR | CPU_FTR_SAO)
>> +	    CPU_FTR_DSCR | CPU_FTR_SAO | CPU_FTR_TLBIE_206)
>> #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>> 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>> 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
>
> I think our preference is to use MMU features for such things now  
> instead of burning a cpu feature for it.

I see Ben has already made this comment.. so I just second his notion.

- k
