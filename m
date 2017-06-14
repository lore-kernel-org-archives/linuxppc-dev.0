Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnktk5qKxzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 21:29:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/13] powerpc/64s: idle process interrupts from system
 reset wakeup
In-Reply-To: <20170613232851.37195c34@roar.ozlabs.ibm.com>
References: <20170613130557.26315-1-npiggin@gmail.com>
 <20170613130557.26315-4-npiggin@gmail.com>
 <20170613232851.37195c34@roar.ozlabs.ibm.com>
Date: Wed, 14 Jun 2017 21:29:32 +1000
Message-ID: <87k24e3izn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Tue, 13 Jun 2017 23:05:47 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>
>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>> index f06112cf8734..8366bdc69988 100644
>> --- a/arch/powerpc/include/asm/hw_irq.h
>> +++ b/arch/powerpc/include/asm/hw_irq.h
>> @@ -32,6 +32,7 @@
>>  #ifndef __ASSEMBLY__
>>  
>>  extern void __replay_interrupt(unsigned int vector);
>> +extern void __replay_wakeup_interrupt(unsigned long srr1);
>>  
>>  extern void timer_interrupt(struct pt_regs *);
>>  extern void performance_monitor_exception(struct pt_regs *regs);
>
> Oops, just noticed this remnant from an earlier version. Please
> ignore this hunk.

Done.

cheers
