Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 056F91007D3
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Dec 2009 14:27:01 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nB23QhCj019403
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Dec 2009 20:26:53 -0700 (MST)
Subject: Re: [PATCH v3 3/3] powerpc/fsl: 85xx: add cache-sram support
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <4B154C82.5060100@freescale.com>
Date: Tue, 1 Dec 2009 21:26:41 -0600
Message-Id: <4FFF0261-B265-4087-B2BB-6C9A7FFDA01A@freescale.com>
References: <F2F605B667B24B489C904986E0D60A0801222492@zin33exm23.fsl.freescale.net>
	<4B154C82.5060100@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Mahajan Vivek-B08308 <B08308@freescale.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 1, 2009, at 11:04 AM, Scott Wood wrote:

> Mahajan Vivek-B08308 wrote:
>>> From: Wood Scott-B07421 Sent: Friday, November 20, 2009 11:09 PM
>>>> Cache-sram does not have any device tree entry since it is not a  
>>>> hardware as such. Putting it under chosen can be another option.
>>>> I think, Scott (cc'ed) was of the opinion that since 32b
>>> base address
>>>> support is missing; so there is no point in moving this
>>> address to the
>>>> command line and .config should be okay for now for it.
>>> I don't know what you mean by "32b base address support is  
>>> missing".  I have no objection to putting it on the command line.
>> It was a typo, it should be missing 36b address support. Since the
>> kernel did not run under different environment (i.e 32b / 36b base  
>> address); so
>> it was decided that .config may be okay for this.
>
> The kernel *will* run with a 36-bit address map even if some of our  
> drivers don't support it right at the moment -- so we should be  
> planning for it.

Not only that but I'd like to move any future parts to only support a  
36-bit memory map.

- k
