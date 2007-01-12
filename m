Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 20928DE008
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 23:26:39 +1100 (EST)
In-Reply-To: <20070112104211.GQ11226@localhost.localdomain>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
	<20070112084612.GJ11226@localhost.localdomain>
	<45A74E2F.2000901@246tNt.com>
	<20070112104211.GQ11226@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64469e5c846c386f30ae618752697ed6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Date: Fri, 12 Jan 2007 13:27:14 +0100
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I'm not saying the system is perfect but this issue is more related to
>> recent
>> bindings that the of thing as a whole. That's more the problem with of
>> is that
>> when you need to define bindings for something that has none, you may 
>> not
>> anticipate everything ....
>
> No, you can never do that.

It is perfectly possible to create a binding for a single
device without making any omissions/errors.

You can do a corrrect implementation, too.

Doing this for a whole platform is not more difficult,
just more works (and the law of big numbers kicks in,
you're likely to make some mistake).

> Lets hope there will never be incompatible
> changes in the device tree so that we have to use this device tree for 
> this
> kernel version and another one for other kernel versions.

That wouldn't ever be needed if your "binding" isn't
hopelessly lacking.


Segher
