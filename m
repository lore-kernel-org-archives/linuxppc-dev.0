Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3340DDF33
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:31:17 +1000 (EST)
In-Reply-To: <1179499713.12981.75.camel@chaos>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>
	<464C99FF.8080404@ru.mvista.com>
	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
	<464C9E67.2020909@ru.mvista.com>
	<6E0D5E13-C939-4FCE-81A3-F29DFA6436A2@kernel.crashing.org>
	<464CA222.8000407@ru.mvista.com> <464D9E7E.3090605@genesi-usa.com>
	<464DADFC.3080802@ru.mvista.com> <464DB800.40702@genesi-usa.com>
	<1179499713.12981.75.camel@chaos>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <32E780BE-58B7-4303-AA49-1852C4C7EB50@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
Date: Fri, 18 May 2007 11:31:19 -0500
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2007, at 9:48 AM, Thomas Gleixner wrote:

> On Fri, 2007-05-18 at 15:28 +0100, Matt Sealey wrote:
>>>> I guess the real question is, how high resolution does a high  
>>>> resolution
>>>> timer need to be,
>>>
>>>    In the order of microseconds.
>>
>> I think both the MPC52xx GPT0-7 and the SLT0-1 fulfil this fairly
>> easily.
>
> There is some basic work for MPC5200 available:
>
> http://www.pengutronix.de/oselas/bsp/phytec/index_en.html#phyCORE- 
> MPC5200B-tiny

I asked this earlier, but figured you might have a better insight.   
Is their value in having 'drivers' for more than one clock source?   
I'd say most (of not all) the PPC SoCs have timers on the system side  
that we could provide drivers for, I'm just not sure if that does  
anything for anyone.

- k
