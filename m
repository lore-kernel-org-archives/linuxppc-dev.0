Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2D82DE256
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 03:56:48 +1100 (EST)
Message-ID: <47DFF445.20708@freescale.com>
Date: Tue, 18 Mar 2008 11:56:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2] 8xx: Add support for the MPC852 based board from
	keymile.
References: <20080318161957.766A124349@gemini.denx.de>
In-Reply-To: <20080318161957.766A124349@gemini.denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Heiko Schocher <hs@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> Dear Scott,
> 
> in message <20080318151132.GA17402@ld0162-tx32.am.freescale.net> you wrote:
>> Well, the device tree is a mechanism for communicating from the firmware
>> to the kernel, and if we could control the firmware better we'd just make
>> it set the pins properly to begin with. :-)
> 
> Is this just a comment, or do you oppose Heiko's suggestion?

It was intended more as a gentle nudge to set up the pins in firmware 
when not constrained by existing firmwares in the field that must be 
supported.

> Other uses of the device tree seem possible and reasonable, too.  For
> example, we can use the device tree to configure the firmware (U-Boot
> in this case).
> 
> Using the device tree  to  describe  the  pin  configuration  of  the
> hardware  sounds  easier to me than hard-coding it in some source (or
> header) file - no matter if this is  in  the  kernel  and/or  in  the
> firmware.
> 
> What do you think?

I'm fine with putting it in the device tree for firmware's benefit, 
though I'm not sure I fully agree with the "easier" bit until we get 
support for expressions and named constants in dts, so that the flags 
would be less opaque.

-Scott
