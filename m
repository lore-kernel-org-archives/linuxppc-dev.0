Return-Path: <neko@genesi-usa.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id A9E5BDDF42
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:04:17 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so1957859nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 14:04:15 -0700 (PDT)
Message-ID: <47EABA4B.1000105@genesi-usa.com>
Date: Wed, 26 Mar 2008 21:04:11 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/5] leds: implement OpenFirmare GPIO LEDs driver
References: <20080326202453.GC1772@localhost.localdomain>
	<fa686aa40803261357m4a8e8703u7f3b8e39199e1de7@mail.gmail.com>
In-Reply-To: <fa686aa40803261357m4a8e8703u7f3b8e39199e1de7@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can someone throw me a link to the GPIO spec being implemented here (yes,
I would like docs too!) or a pointer to the relevant DTS which implements
it?

Supporting GPIO in the device tree is something that has been undefined
for ages, and I seem to not be able to find the supporting DTS patches for
this implementation in patchwork..??

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Grant Likely wrote:
> On Wed, Mar 26, 2008 at 2:24 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
>> Despite leds-gpio and leds-of-gpio similar names and purposes, there
>>  is actually very few code can be shared between the two (both drivers
>>  are mostly the driver bindings anyway).
>>
>>  Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Other than the fact that it needs some documentation of the binding in
> booting-without-of.txt, it looks pretty good to me.
> 
> g.
> 
> 
