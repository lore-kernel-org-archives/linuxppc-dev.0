Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 898EEDDF55
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 06:54:25 +1000 (EST)
Message-ID: <48C8339F.1080906@freescale.com>
Date: Wed, 10 Sep 2008 15:52:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: arch/powerpc/boot/.gitignore questions
References: <48C81ED5.1030701@oracle.com>	<20080910164046.4813753b@wally.pikatech.com>
	<20080910204923.D06D7248A6@gemini.denx.de>
In-Reply-To: <20080910204923.D06D7248A6@gemini.denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> Dear Sean MacLennan,
> 
> In message <20080910164046.4813753b@wally.pikatech.com> you wrote:
>> I believe if the dts is built into u-boot, the dtc is not built.
> 
> This is never the case. The device tree is considered to be  part  of
> and provided to the boot loader by the kernel.

No, it's provided to the kernel by the firmware.  That the repository 
for the files that the user provides to u-boot for this purpose happens 
to live in the Linux source tree is irrelevant.

-Scott
