Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A7A8DDE2E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 00:53:00 +1000 (EST)
Message-ID: <46F7CF2F.9070805@freescale.com>
Date: Mon, 24 Sep 2007 09:52:31 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
In-Reply-To: <20070924050709.GM8058@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>>  		i2c@3100 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>>  			device_type = "i2c";
> 
> Hrm... we probably want an "i2c" device_type class, but I don't think
> we've actually defined one, which is a problem

Right... but we need to get the kernel to stop expecting the device type 
to be there before we yell at people for including it. :-)

> The fact that NVRAM+RTC chips are so common is a bit of an issue from
> the point of view of defining a device class binding - a device can't
> have type "rtc" and "nvram".

This is one of the reasons that I'd prefer to use compatible for such 
things.

-Scott
