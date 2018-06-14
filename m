Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4160mP3kCDzDrqN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 20:51:33 +1000 (AEST)
Subject: Re: stacktrace.c:(.text+0x1b0): undefined reference to
 `.smp_send_safe_nmi_ipi'
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <0ae99ba5-e721-dada-8d94-b223e41977e9@c-s.fr>
 <20180614202546.24d40e51@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <62c0b560-5211-4844-1210-6dcd9e2c5526@c-s.fr>
Date: Thu, 14 Jun 2018 12:51:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180614202546.24d40e51@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 14/06/2018 à 12:25, Nicholas Piggin a écrit :
> On Thu, 14 Jun 2018 12:06:51 +0200
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> See http://kisskb.ellerman.id.au/kisskb/buildresult/13395345/ for details
>>
>> Seems like that function only exists when CONFIG_NMI_IPI is defined.
>>
>> Problem introduced by commit 5cc05910f26e6fd6da15f052f86f6150e4b91664
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/kernel/stacktrace.c?h=next-20180614&id=5cc05910f26e6fd6da15f052f86f6150e4b91664
>>
>>
>> What do you recommend to fix that ?
> 
> We could just do smp_call_function in the case we have no NMI_IPI?

???

Can you detail what you have in mind ? Do smp_call_function() to call 
what ? Instead of the call to smp_send_safe_nmi_ipi() ?

Thanks
Christophe

> 
> Thanks,
> Nick
> 
