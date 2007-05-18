Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 04CC2DDED2
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 01:41:55 +1000 (EST)
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
From: Daniel Walker <dwalker@mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <464DC0DC.7050809@ru.mvista.com>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>
	<464C99FF.8080404@ru.mvista.com>
	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
	<1179500217.20519.53.camel@imap.mvista.com>
	<464DC0DC.7050809@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 18 May 2007 08:39:33 -0700
Message-Id: <1179502773.20519.56.camel@imap.mvista.com>
Mime-Version: 1.0
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

On Fri, 2007-05-18 at 19:06 +0400, Sergei Shtylyov wrote:
> Daniel Walker wrote:
> 
> >>I haven't looked at all the new clock/timer code, is there any  
> >>utility in having support for more than one clock source?
> 
> > There is if the main clocksource has some issues where it can't be used.
> 
>     You mean, having more than one clocksource is *useful* in this case?

Yes.

>     Well, the decrementer frequency may change, at least in theory (if the bus 
> clock changes).

Does that happen very often?

Daniel
