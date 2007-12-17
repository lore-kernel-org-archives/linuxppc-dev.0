Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE68DDDDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 03:08:57 +1100 (EST)
Message-ID: <47669285.8010707@freescale.com>
Date: Mon, 17 Dec 2007 09:15:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 1/3] 8xx: Analogue & Micro Adder875 board support.
References: <20071212225427.GA19027@loki.buserror.net>
	<20071217035706.GA3262@localhost.localdomain>
In-Reply-To: <20071217035706.GA3262@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Dec 12, 2007 at 04:54:27PM -0600, Scott Wood wrote:
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
> [snip]
>> diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts b/arch/powerpc/boot/dts/adder875-redboot.dts
>> new file mode 100644
>> index 0000000..4d28220
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/adder875-redboot.dts
> [snip]
>> diff --git a/arch/powerpc/boot/dts/adder875-uboot.dts b/arch/powerpc/boot/dts/adder875-uboot.dts
>> new file mode 100644
>> index 0000000..33d198c
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/adder875-uboot.dts
> 
> Having two different device trees for the different firmwares is
> pretty yucky, and could be a pain in the bum for synchronization of
> fixes.

Yes, that's why we need some sort of macro/template facility in dtc. :-)

> Can't you have a common tree, and just poke the places that
> are differently configured by the two firmwares from the bootwrapper.

Enh.  That can get icky as well, and the bootwrapper isn't necessarily 
even used for u-boot, and I'd rather not require it be used just for this.

-Scott
