Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 31D3DDE2AB
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 10:07:08 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so1997791nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 16:07:07 -0700 (PDT)
Date: Thu, 27 Mar 2008 02:07:00 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH 3/5] leds: implement OpenFirmare GPIO LEDs driver
Message-ID: <20080326230700.GB2799@zarina>
References: <20080326202453.GC1772@localhost.localdomain>
	<fa686aa40803261357m4a8e8703u7f3b8e39199e1de7@mail.gmail.com>
	<47EABA4B.1000105@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47EABA4B.1000105@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 09:04:11PM +0000, Matt Sealey wrote:
> Can someone throw me a link to the GPIO spec being implemented here (yes,
> I would like docs too!) or a pointer to the relevant DTS which implements
> it?
>
> Supporting GPIO in the device tree is something that has been undefined
> for ages, and I seem to not be able to find the supporting DTS patches for
> this implementation in patchwork..??

Here the last respin starts:

http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052881.html

> Grant Likely wrote:
>> On Wed, Mar 26, 2008 at 2:24 PM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>>> Despite leds-gpio and leds-of-gpio similar names and purposes, there
>>>  is actually very few code can be shared between the two (both drivers
>>>  are mostly the driver bindings anyway).
>>>
>>>  Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>
>> Other than the fact that it needs some documentation of the binding in
>> booting-without-of.txt, it looks pretty good to me.

Thanks, will document it.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
