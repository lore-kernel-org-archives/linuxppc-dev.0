Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3ds1413pzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:31:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Michael Ellerman <patch-notifications@ellerman.id.au>,
 Rashmica Gupta <rashmicy@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,1/2] powerpc/mm: Dump linux pagetables
In-Reply-To: <e858f33a-ee89-7a7c-02d6-de4e8ac32e26@c-s.fr>
References: <3tKKXq67gcz9t1T@ozlabs.org>
 <e858f33a-ee89-7a7c-02d6-de4e8ac32e26@c-s.fr>
Date: Thu, 13 Apr 2017 21:31:00 +1000
Message-ID: <87r30w8ryj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Hi Rashmica,
>
> Le 17/11/2016 =C3=A0 13:03, Michael Ellerman a =C3=A9crit :
>> On Fri, 2016-27-05 at 05:48:59 UTC, Rashmica Gupta wrote:
>>> Useful to be able to dump the kernels page tables to check permissions
>>> and memory types - derived from arm64's implementation.
>>>
>>> Add a debugfs file to check the page tables. To use this the PPC_PTDUMP
>>> config option must be selected.
>>>
>>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
>>
>> Applied to powerpc next, thanks.
>>
>> https://git.kernel.org/powerpc/c/8eb07b187000d48152c4ef97f075bd
>
> For your information, compilation fails on mpc885_ads_defconfig when we=20
> activate PPC_PTDUMP:
>
>    CC      arch/powerpc/mm/dump_linuxpagetables.o
> arch/powerpc/mm/dump_linuxpagetables.c: In function 'walk_pagetables':
> arch/powerpc/mm/dump_linuxpagetables.c:369:10: error: 'KERN_VIRT_START'=20
> undeclared (first use in this function)

Yeah it's basically 64-bit only at the moment.

I have a TODO for it: https://github.com/linuxppc/linux/issues/88

But I haven't got around to doing it, maybe someone who has more
interest in 32-bit will have time before me ;)

cheers
