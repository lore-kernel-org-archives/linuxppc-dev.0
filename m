Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 3916567A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 10:06:30 +1100 (EST)
In-Reply-To: <20050302105201.C31614@cox.net>
References: <20050302105201.C31614@cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b83e8f546345414634e6c7518b441996@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 2 Mar 2005 17:06:31 -0600
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: PowerPC4xx Watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt,

[snip]

> What do you see as the advantage to having a watchdog driver
>  that uses the booke hardware watchdog facility over a generic
>  timebase driven driver?

I would think the watchdog would be useful in cases that the normal 
decrementer exceptions gets disabled when MSR[EE] = 0.

- kumar
