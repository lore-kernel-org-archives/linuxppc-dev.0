Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0942B67C2D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 03:05:29 +1100 (EST)
In-Reply-To: <950a36fb0612140801x39de08c2gd3ad5ce9ba04f900@mail.gmail.com>
References: <950a36fb0612140241n15ca51e5xb8a9bb98888befb8@mail.gmail.com>
	<8B63C317-4AC7-421C-8536-B68ED900127A@kernel.crashing.org>
	<950a36fb0612140801x39de08c2gd3ad5ce9ba04f900@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <72D2A043-FCCB-4781-9764-1A398A611D0E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.19] enable watchdog device on mpc834x platforms
Date: Thu, 14 Dec 2006 10:05:28 -0600
To: "Pieter-Jan Busschaert" <pieterjan.busschaert@gmail.com>
Cc: "linuxppc-embedded@ozlabs.org \(\(\(\(E-Mail\)\)\)\)"
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 14, 2006, at 10:01 AM, Pieter-Jan Busschaert wrote:

>> Two things about this patch:
>> 1. We've actively avoid taking non-bug fix patches to arch/ppc as we
>> try to move people over to arch/powerpc.
>> 2. You can't hard code freq in the platform data like that.  It's
>> expected to be the bus frequency the device is running at.
>
> The frequency is only used once in the driver to printk the
> watchdog-timeout in seconds. It doesn't affect the functionallity in
> any way. I looked at ways to get the cpu frequency dynamically in
> there, but didn't find a simple way to do it.

It does, in that the drive reports it on a WDIOC_GETTIMEOUT to user  
space.  (See how we use timeout_sec).

> But, because of your first comment, I suppose this patch will never
> enter the linux kernel, even if I get the frequency dynamically?

Most likely, but its still good to have the patches on the list for  
people to pull if they need them.

- k
