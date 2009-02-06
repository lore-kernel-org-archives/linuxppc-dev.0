Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 8428ADDEE3
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:54:27 +1100 (EST)
In-Reply-To: <1233720433.16867.185.camel@pasglop>
References: <1231160724_126472@mercury.realtime.net>
	<1233720433.16867.185.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6eae2dfd216825bd50e057005780ca5e@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: use common cpu_die
Date: Fri, 6 Feb 2009 11:02:34 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 3, 2009, at 10:07 PM, Benjamin Herrenschmidt wrote:
>> --- work.git.orig/arch/powerpc/platforms/powermac/setup.c-static void 
>> pmac_cpu_die(void)
>> +static void pmac64_cpu_die(void)
  ...
>> --- work.git.orig/arch/powerpc/platforms/powermac/smp.c	2009-01-05 
>> 02:09:08.000000000 -0600
>> -void cpu_die(void)
>> +void pmac32_cpu_die(void)
>>  {
>>  	local_irq_disable();
>>  	cpu_dead[smp_processor_id()] = 1;
>
> Hi Milton ! Any chance you can move both pmac32 and pmac64 variants 
> into
> the same file ?

I'm sure I could, but (1) it should be an incremental patch, (2) it 
would only be compile tested again, and (3)  I didn't look to see how 
it would fit.  I was doing the minimal patch that left the code intact; 
it's possible that more consolidation could be done.

milton
