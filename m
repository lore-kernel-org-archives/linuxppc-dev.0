Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id EDBA868065
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 10:21:39 +1100 (EST)
Message-ID: <455114F9.2010503@ru.mvista.com>
Date: Wed, 08 Nov 2006 02:21:29 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: clockevents and HRT support
References: <200611080005.08633.sshtylyov@ru.mvista.com>	
	<1162938997.28571.534.camel@localhost.localdomain>	
	<45510C58.3010707@ru.mvista.com>
	<1162940684.28571.537.camel@localhost.localdomain>
In-Reply-To: <1162940684.28571.537.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, greg.weeks@timesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:
>>    That's not equivalent. What I wanted to cover with this option was 970 
>>weirdness of the decrementer interrupts being level triggered and effectively 
>>tied to the MSB of the decremeneter register...
>>    Also, 40x decrementer is not Book E compatible.

> Well... Is this specific to the 970 or also happens on all
> POWER4..5..6 ? (I don't remember off the top of my head). It should
> probably be a runtime check then.

    I don't have the docs on POWER[456], so can't say anything.

>>>Also, what's the problem with ppc64 deterministic accounting that you
>>>can't fix it ?

>>    Arch-specific accounting hooks which this feature makes use of can't be 
>>called from the generic clockevents code.

> Then the generic clockevent code will have to be fixed or powerpc not
> ported to it.

    Whatever. I don't care about that feature. I did my best to solve this 
gracefully.

> Ben.

WBR, Sergei
