Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3FF43DDF1A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:29:35 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l47LTT55000690
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 14:29:30 -0700 (MST)
Message-ID: <463F9A38.6080408@freescale.com>
Date: Mon, 07 May 2007 16:29:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 05/13] Document the fsl, magic-packet property in gianfar
	nodes.
References: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
	<B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
In-Reply-To: <B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:
> On May 7, 2007, at 13:29, Scott Wood wrote:
>> +   Optional properties:
>> +    - fsl,magic-packet : Indicates that this device supports wake
>> +      on Magic Packet.
>> +
> 
> 
> Isn't this a fairly generic option?  Does it need the "fsl" qualifier?

As I previously wrote internally, it's only needed because some versions 
of the device have it and some don't; what it really means is that 
certain bits in certain registers are valid.  Making it generic would 
imply that all hardware that can do magic packet should have it, which 
isn't true.

-Scott
