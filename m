Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 203E7DDF1B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 00:59:20 +1000 (EST)
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
From: Daniel Walker <dwalker@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>
	<464C99FF.8080404@ru.mvista.com>
	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 18 May 2007 07:56:57 -0700
Message-Id: <1179500217.20519.53.camel@imap.mvista.com>
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

On Thu, 2007-05-17 at 13:17 -0500, Kumar Gala wrote:

> 
> I haven't looked at all the new clock/timer code, is there any  
> utility in having support for more than one clock source?

There is if the main clocksource has some issues where it can't be used.
On x86 there are lots of different issues with the clocks, so they have
to get switches once in a while. For instance, if the TSC changes
frequencies then it can't be used, or if the TSC stops in different
power states , it can't be used.. 

Anything like that on PowerPC?

Daniel
