Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id DEFE8DDEF4
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 01:04:34 +1000 (EST)
Message-ID: <464DC0DC.7050809@ru.mvista.com>
Date: Fri, 18 May 2007 19:06:04 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
References: <200705172142.26739.sshtylyov@ru.mvista.com>	
	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>	
	<464C99FF.8080404@ru.mvista.com>	
	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
	<1179500217.20519.53.camel@imap.mvista.com>
In-Reply-To: <1179500217.20519.53.camel@imap.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Daniel Walker wrote:

>>I haven't looked at all the new clock/timer code, is there any  
>>utility in having support for more than one clock source?

> There is if the main clocksource has some issues where it can't be used.

    You mean, having more than one clocksource is *useful* in this case?

> On x86 there are lots of different issues with the clocks, so they have
> to get switches once in a while. For instance, if the TSC changes
> frequencies then it can't be used, or if the TSC stops in different
> power states , it can't be used.. 

    Yeah, and there's the rating systems for both clock sources/events.

> Anything like that on PowerPC?

    Well, the decrementer frequency may change, at least in theory (if the bus 
clock changes).

> Daniel

WBR, Sergei
