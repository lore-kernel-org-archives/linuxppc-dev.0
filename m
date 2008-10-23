Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 6D89EDDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 08:35:13 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so211990qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 14:35:11 -0700 (PDT)
Message-ID: <4900EE0F.3090105@genesi-usa.com>
Date: Thu, 23 Oct 2008 16:35:11 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Specify GPIO number base for controller in DT
References: <1224764850.4082.54.camel@galileo.recco.de>
	<5535CAC8-11C4-4262-9B18-5F6416A51DE3@kernel.crashing.org>
In-Reply-To: <5535CAC8-11C4-4262-9B18-5F6416A51DE3@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Ocker <weo@reccoware.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Kumar Gala wrote:
> 
> On Oct 23, 2008, at 7:27 AM, Wolfgang Ocker wrote:
> 
>> The GPIOLIB allows the specification of a base gpio number for a
>> controller. That is not possible using OF. Instead, free gpio numbers
>> are assigned.
>>
>> In order to allow static, predefined gpio numbers, a base property in
>> the gpio controller node specifies the first gpio number.

See my latest mail.

I don't think it's enough to say which pin the GPIOs exposed 
start at; you need some sort of mask, or array of applicable 
GPIOs so that GPIOLIB can check which perhaps 3 pins out of a 
possible 32 are allocated to a controller and usable (these 
may be pin 5, pin 9 and pin 20, so a "base" of pin 5 would be 
outrageously inadequate).

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
