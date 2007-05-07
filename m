Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E821DDE39
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:51:32 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l47LpSB5012992
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 14:51:28 -0700 (MST)
In-Reply-To: <463F9A38.6080408@freescale.com>
References: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
	<B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
	<463F9A38.6080408@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AC7B08C0-E41A-458F-8E9F-59901443600A@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 05/13] Document the fsl,
	magic-packet property in gianfar nodes.
Date: Mon, 7 May 2007 16:51:36 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2007, at 16:29, Scott Wood wrote:

> Andy Fleming wrote:
>> On May 7, 2007, at 13:29, Scott Wood wrote:
>>> +   Optional properties:
>>> +    - fsl,magic-packet : Indicates that this device supports wake
>>> +      on Magic Packet.
>>> +
>> Isn't this a fairly generic option?  Does it need the "fsl"  
>> qualifier?
>
> As I previously wrote internally, it's only needed because some  
> versions of the device have it and some don't; what it really means  
> is that certain bits in certain registers are valid.  Making it  
> generic would imply that all hardware that can do magic packet  
> should have it, which isn't true.


Yeah, I just read that.  You should either make that more explicit in  
the documentation, or make it generic.  It's fine if there are  
drivers/devices that don't need to be told or tell anyone that they  
recognize magic packets for them to work.  The lack of the property  
in other controllers won't break anything.

But I'm fine if you just document that the bit indicates,  
specifically, the presence of magic-packet bits in certain registers  
on the eTSEC.

Andy
