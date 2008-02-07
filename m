Return-Path: <kaloz@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [195.56.146.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B0AEDDEC2
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 01:35:52 +1100 (EST)
Date: Thu, 07 Feb 2008 15:35:43 +0100
To: "Valentine Barshak" <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] MTD support for the AMCC Taishan
From: "Imre Kaloz" <kaloz@openwrt.org>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
References: <120203530465-git-send-email-kaloz@openwrt.org>
	<op.t55gr5lb2s3iss@ecaz.afh.b-m.hu>
	<20080207060012.788e4258@zod.rchland.ibm.com>
	<47AB0BC3.2000202@ru.mvista.com>
	<op.t55p8elk2s3iss@ecaz.afh.b-m.hu> <47AB1023.9040707@ru.mvista.com>
Message-ID: <op.t55r5tt22s3iss@ecaz.afh.b-m.hu>
In-Reply-To: <47AB1023.9040707@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 07 Feb 2008 15:05:23 +0100, Valentine Barshak  
<vbarshak@ru.mvista.com> wrote:

>> Well, arch/ppc calculates the mtd2 dynamically and doesn't create
>> a separate partition for kozio.
>
> That dynamic size calculation depends on the flash size.
> The board I use has a 64MB NOR flash (I'm not aware of other Taishan  
> boards having chips of different size). So AFAIU if such board exists,  
> we'll need a cuboot flash-size fixup.


All Taishan boards have 64MB flash (2x32MB). Denx was doing the size  
calculation
to dynamically allocate mtd2 based on the size of mtd0+mtd1 if I recall  
right.


Cheers,
Imre
