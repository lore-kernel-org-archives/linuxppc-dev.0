Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2ABF9DDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 04:33:14 +1000 (EST)
In-Reply-To: <464C9E67.2020909@ru.mvista.com>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>
	<464C99FF.8080404@ru.mvista.com>
	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
	<464C9E67.2020909@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6E0D5E13-C939-4FCE-81A3-F29DFA6436A2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
Date: Thu, 17 May 2007 13:31:24 -0500
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
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


On May 17, 2007, at 1:26 PM, Sergei Shtylyov wrote:

> Hello.
>
> Kumar Gala wrote:
>
>> I haven't looked at all the new clock/timer code, is there any   
>> utility in having support for more than one clock source?
>
>    Of course, you may register as many as you like.

Sure, but is there any utility in registering more than the  
decrementer on PPC?

- k
