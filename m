Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFBB5DDF41
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 11:15:35 +1000 (EST)
In-Reply-To: <1158362585.2622.27.camel@vader.jdub.homelinux.org>
References: <20060824123841.4756.qmail@web36601.mail.mud.yahoo.com>
	<1156423796.5640.23.camel@zod.rchland.ibm.com>
	<1156424295.19482.11.camel@localhost>
	<20060824132338.GA27468@gate.crashing.org>
	<c3d0340b0609151606i2d01b963h4c7cd6a182d8c80@mail.gmail.com>
	<1158362585.2622.27.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4E1AC218-F960-4B82-AB21-9DD90511AC3B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: ARCH=ppc or ARCH=powerpc
Date: Wed, 27 Jun 2007 20:14:45 -0500
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: Matt Porter <mporter@embeddedalley.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 15, 2006, at 6:23 PM, Josh Boyer wrote:

> On Fri, 2006-09-15 at 16:06 -0700, Shawn Jin wrote:
>> Hi Matt,
>>
>>> The goal is to have the new 4xx arch/powerpc support not break 4xx
>>> arch/ppc support. So as boards are merged and verified working,
>>> we'll remove the equivalent support from arch/ppc...
>>>
>>> Some boards/chips may just die if no maintainer step up to port
>>> them over...but all the important stuff should get an interested
>>> party once we get the initial 4xx support in arch/powerpc working.
>>
>> When can we expect this done? I have a 440 based SoC project ongoing
>> and am thinking when I should start moving to arch/powerpc.
>
> There is no set date or kernel release where this will be done.  In
> other words "when it gets done, it gets done". :)

There is some push for putting a date one year from now as when arch/ 
ppc will go away.

- k
