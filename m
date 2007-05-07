Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D30DDDEEC
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 09:07:40 +1000 (EST)
In-Reply-To: <AC7B08C0-E41A-458F-8E9F-59901443600A@freescale.com>
References: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
	<B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
	<463F9A38.6080408@freescale.com>
	<AC7B08C0-E41A-458F-8E9F-59901443600A@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3FE06AFA-BEE6-46CF-B12C-29D979AE50D7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 05/13] Document the fsl,
	magic-packet property in gianfar nodes.
Date: Mon, 7 May 2007 18:06:39 -0500
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2007, at 4:51 PM, Andy Fleming wrote:

>
> On May 7, 2007, at 16:29, Scott Wood wrote:
>
>> Andy Fleming wrote:
>>> On May 7, 2007, at 13:29, Scott Wood wrote:
>>>> +   Optional properties:
>>>> +    - fsl,magic-packet : Indicates that this device supports wake
>>>> +      on Magic Packet.
>>>> +
>>> Isn't this a fairly generic option?  Does it need the "fsl"
>>> qualifier?
>>
>> As I previously wrote internally, it's only needed because some
>> versions of the device have it and some don't; what it really means
>> is that certain bits in certain registers are valid.  Making it
>> generic would imply that all hardware that can do magic packet
>> should have it, which isn't true.
>
>
> Yeah, I just read that.  You should either make that more explicit in
> the documentation, or make it generic.  It's fine if there are
> drivers/devices that don't need to be told or tell anyone that they
> recognize magic packets for them to work.  The lack of the property
> in other controllers won't break anything.
>
> But I'm fine if you just document that the bit indicates,
> specifically, the presence of magic-packet bits in certain registers
> on the eTSEC.

I'd ask is it really freescale specific?  In that I'd assume its  
support for the standard wake-on-lan packet.

- k
