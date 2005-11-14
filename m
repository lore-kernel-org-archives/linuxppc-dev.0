Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F56E68748
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 08:14:35 +1100 (EST)
In-Reply-To: <20051114160302.GC29411@logos.cnet>
References: <20051114143821.GA28852@logos.cnet>
	<9E7D3814-47AB-4601-A565-2530C3A4BEE0@kernel.crashing.org>
	<20051114155736.GB29411@logos.cnet>
	<20051114160302.GC29411@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1A6D4EAD-CB3F-4630-B0EC-7B89D33303EC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 14 Nov 2005 15:14:54 -0600
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Florian Schirmer <jolt@tuxbox.org>, obi@saftware.de, carjay@gmx.de,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] m8xx_wdt: software watchdog reset/interrupt select\
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 14, 2005, at 10:03 AM, Marcelo Tosatti wrote:

> On Mon, Nov 14, 2005 at 01:57:37PM -0200, Marcelo Tosatti wrote:
>> Hi Kumar,
>>
>> On Mon, Nov 14, 2005 at 02:55:24PM -0600, Kumar Gala wrote:
>>> Can we put the WDT for 8xx in drivers/char/watchdog/?
>>
>> The userspace interface is already there at
>> drivers/char/watchdog/mpc8xx_wdt.c. I don't any reason for having two
>> files, will try to merge them into drivers/.
>
> Actually, drivers/char/watchdog/mpc8xx_wdt.c is a module, while
> some of the initialization code must reside in the kernel image.
>
> Thats the reason for the split - not sure if merging the two
> files is worth?

Fair enough.

- kumar
