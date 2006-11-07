Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56DF467DAD
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 10:04:56 +1100 (EST)
Subject: Re: [PATCH] PowerPC: clockevents and HRT support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <45510C58.3010707@ru.mvista.com>
References: <200611080005.08633.sshtylyov@ru.mvista.com>
	<1162938997.28571.534.camel@localhost.localdomain>
	<45510C58.3010707@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 10:04:44 +1100
Message-Id: <1162940684.28571.537.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, greg.weeks@timesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>     That's not equivalent. What I wanted to cover with this option was 970 
> weirdness of the decrementer interrupts being level triggered and effectively 
> tied to the MSB of the decremeneter register...
>     Also, 40x decrementer is not Book E compatible.

Well... Is this specific to the 970 or also happens on all
POWER4..5..6 ? (I don't remember off the top of my head). It should
probably be a runtime check then.

> > Also, what's the problem with ppc64 deterministic accounting that you
> > can't fix it ?
> 
>     Arch-specific accounting hooks which this feature makes use of can't be 
> called from the generic clockevents code.

Then the generic clockevent code will have to be fixed or powerpc not
ported to it.

Ben.
