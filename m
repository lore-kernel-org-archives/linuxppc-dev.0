Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 8781867A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 22:51:31 +1100 (EST)
Message-ID: <4226FA13.6020203@jp.fujitsu.com>
Date: Thu, 03 Mar 2005 20:50:43 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <20050302105201.C31614@cox.net>	<b83e8f546345414634e6c7518b441996@freescale.com>
	<20050302161530.D31614@cox.net>
In-Reply-To: <20050302161530.D31614@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Matt and Kurmar,

Thank you for your response.

 >>>What do you see as the advantage to having a watchdog driver
 >>> that uses the booke hardware watchdog facility over a generic
 >>> timebase driven driver?
 >>
I do not think that there is especially an important
reason to use the hardware watchdog as your saying
though it noticed by thinking later.

Therefore, I agrees the shortest way of implementing
the driver is fixing minor things of a old ppc405 driver.

However, I posted the new driver for the following reasons.

1) The old driver depends on HZ value (10ms).
2) The old driver doesn't support e500.
3) When the last mail was sent, it had finished
    writing the driver to certain extent.

So, we are
 > That's the only thing I can think of.  I guess my question then
 > is whether people think this is important enough in practice
 > to have the hardware watchdog as an alternative. My guess is yes,
 > but I don't have a strong opinion.
 >
I also thought like that before.

Certainly, this case doesn't become a big problem
while it is developing on the evaluation boards.

However, a lot of users think that they install
Linux on the custom board, and ships the product.
When the problem of causing hanging up with the interruption disabled
occurs on the custom board, pursuing the cause becomes very
difficult.

In the case that we experienced, it kept operating with the device
  driver became an interruption prohibition, and hanging up was caused
very unusually occasionally.
To solve this problem, we are consuming time of about half a year.

Because the incidence of the problem is very low,
it is important to  the generation part such a problem when generated.

In this case, WDT driver may be good help.

Regards,

-- 
Takeharu KATO
Fujitsu Limited
Email:kato.takeharu at jp.fujitsu.com
