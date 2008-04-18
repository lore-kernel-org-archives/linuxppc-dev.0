Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0AD2DE009
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 23:19:42 +1000 (EST)
Message-Id: <3DA03449-754F-4A10-A45D-0E0C4ADAA44B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1207690574.7442.4.camel@johannes.berg>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v3] powerpc: Add irqtrace support for 32-bit powerpc
Date: Fri, 18 Apr 2008 08:19:22 -0500
References: <20080404213932.GA15847@farnsworth.org>
	<20080407171428.GA14900@farnsworth.org>
	<1207670643.5550.11.camel@johannes.berg>
	<1207690574.7442.4.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 8, 2008, at 4:36 PM, Johannes Berg wrote:
>
>>> This version fixes the clobbering of r12 by the call to
>>> trace_hardirqs_off() that was pointed out by BenH.
>>>
>>> Johannes, I'd appreciate your trying this version if/when
>>> you get the chance.
>>
>> Thanks Dale, this version seems to work. I'll stress it a bit more
>> later, but so far it has survived *much* longer than both previous
>> versions.
>
> Hmm. Bad news. I got a crash in console_callback() again where
> apparently r28 had a bogus value. That, however, doesn't make sense,  
> so
> maybe that register value was calculated from another register.

did we ever figure this out?

- k
