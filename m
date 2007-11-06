Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F20C5DDE03
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 04:10:29 +1100 (EST)
Message-ID: <47309E35.6090207@freescale.com>
Date: Tue, 06 Nov 2007 11:02:45 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>	
	<472F7247.9070106@freescale.com>	
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>	
	<472F8267.8070106@freescale.com>
	<9e4733910711051641m5ff0e651ke9a43daa51fd14b@mail.gmail.com>
In-Reply-To: <9e4733910711051641m5ff0e651ke9a43daa51fd14b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
>>>>> One side effect is that legacy style i2c drivers won't work anymore.
>>>> If you mean legacy-style client drivers, why not?
>>> i2c_new_device() doesn't work with legacy-style client drivers.
>> No, but they should still work the old way.
> 
> I'm not in favor trying to support both legacy and new style i2c
> drivers.

I don't understand what it is that you did that would break support for 
legacy clients, though.

>  It took me all of five minutes to convert an existing legacy
> driver to the new style. Pretty much all you need to do is delete code
> (about 100 lines). So I'd recommend converting the drivers we are
> interest in instead of trying to support both types.

Sure, conversion is good, but that doesn't mean we want things to 
suddenly break for users.

-Scott
