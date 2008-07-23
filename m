Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0033ADDEFF
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 22:52:02 +1000 (EST)
Message-Id: <D1C5B0E0-FC36-4AD4-B502-030D6FCDC2AF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: luisgpm@linux.vnet.ibm.com
In-Reply-To: <1216777678.5727.82.camel@gargoyle>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC] 4xx hardware watchpoint support
Date: Wed, 23 Jul 2008 07:51:13 -0500
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 22, 2008, at 8:47 PM, Luis Machado wrote:

> Hi,
>
>> That, or adding a small function to move the bits to the appropriate
>> registers (set_dbcr or set_dac_events).
>>
>>> Do you think it's worth to support this facility on 405's  
>>> processors? If
>>> so, i'll gladly work on a solution to it.
>>
>> I would think so.  There's really no difference from a userspace
>> perspective, so gdb watchpoints could be valuable there too.  I'll
>> leave it up to you though.
>
> As the 440 support is ready and the 405 needs additional tweaking  
> due to
> the use of DBCR1 instead of DBCR0 and due to a different position  
> scheme
> of the DAC1R/DAC1W flags inside DBCR1, i'd say we should include this
> code and handle the 405 case later.
>
> We might have to handle it anyway if we're going to pursue the  
> hardware
> breakpoint interface work in the future.
>
> I've fixed some formatting problems. Tested on a 440 Taishan board and
> on a PPC970. Both worked as they should. Ok?

I'd like to test this on some Freescale Book-e parts.  Is there a gdb  
patch or some user space ptrace test you have?

- k
