Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8AF48DDEEE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 05:55:43 +1000 (EST)
In-Reply-To: <1179333421.7018.17.camel@ld0161-tx32>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
Date: Wed, 16 May 2007 21:55:33 +0200
To: Jon Loeliger <jdl@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +			isa@f0 {

isa@1e

>> +				8042@60 {
>> +					device_type = "8042";

Drop the device_type.  A number as a name isn't
all that great, either.

>> +				rtc@70 {
>> +					device_type = "rtc";
>> +					reg = <1 70 2>;
>> +				};
>
> Is "rtc" a standard OF device,

Yes, it is defined in the "Device Support Extensions"
recommended practice.

> And is the plan to somehow use this entry in the future?

The platform code can use it to find the device.  If it
would have a proper "compatible" property, the generic
code could do that work, instead.


Segher
