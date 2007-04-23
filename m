Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1571DDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 07:16:08 +1000 (EST)
In-Reply-To: <20070423160621.329d1a08.kim.phillips@freescale.com>
References: <20070423144052.261f68ad.kim.phillips@freescale.com>
	<5c96dd623e3a6737db48ab17c3550610@kernel.crashing.org>
	<20070423160621.329d1a08.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <295ef00589e07afc89ebeb13027936a3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v4] powerpc: document phy-connection-type property
Date: Mon, 23 Apr 2007 23:16:02 +0200
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +   - phy-connection-type : a string naming the controller/PHY
>>> interface type,
>>> +     i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id",
>>> "tbi",
>>> +     or "rtbi".
>>
>> Could you put this right after the "phy-handle" definition
>> please?
>
> phy-handle is a required property, whereas phy-connection-type is not
> (it's recommended). Are you suggesting phy-connection-type be a 
> required
> property?

Oh okay, I didn't see that from context -- no, it
shouldn't be required, most controllers / PHYs don't
need that information.


Segher
