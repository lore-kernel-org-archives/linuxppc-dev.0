Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25574DDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 07:48:06 +1000 (EST)
Message-ID: <46E70CE5.5060508@freescale.com>
Date: Tue, 11 Sep 2007 16:47:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/3] Add 6xx-style HID0_SLEEP support.
References: <20070905220438.GA11283@ld0162-tx32.am.freescale.net>	<20070905220640.GB11353@ld0162-tx32.am.freescale.net>
	<18151.2530.439805.386163@cargo.ozlabs.ibm.com>
In-Reply-To: <18151.2530.439805.386163@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Scott Wood writes:
> 
>> +_GLOBAL(mpc6xx_enter_sleep)
> 
> The name is slightly unfortunate as powerbooks also use 6xx-family
> processors but enter sleep in a quite different manner, because they
> exit sleep with a reset.  Can you think of a better name, that gives a
> hint that this is the one to use if we are exiting sleep with an
> interrupt rather than a reset?

The nomenclature I've been using on 83xx is to call it deep sleep if you 
exit with a reset, but if powerbooks can only do deep sleep, and it's 
already been called plain old "sleep", then I guess something else is 
warranted.

mpc6xx_enter_coreonly_sleep?
mpc6xx_enter_light_sleep?
mpc6xx_enter_standby?

-Scott
