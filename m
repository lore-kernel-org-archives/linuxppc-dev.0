Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48B6C474C6
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 03:00:30 +1100 (EST)
Message-Id: <F2CBFA89-325F-4479-827C-0C5012B755CA@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: "Reynes Philippe" <philippe.reynes@isismpp.fr>
In-Reply-To: <761F451C5F17F74DAEE4661DA5ABBC1616C466@factorix.ISISTHIBAUD.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] add lm75 to mpc 837x rdb dts
Date: Mon, 2 Feb 2009 10:00:17 -0600
References: <761F451C5F17F74DAEE4661DA5ABBC1616C452@factorix.ISISTHIBAUD.local>
	<408550B3-4109-4164-BE42-15D6B6A96871@freescale.com>
	<761F451C5F17F74DAEE4661DA5ABBC1616C466@factorix.ISISTHIBAUD.local>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 2, 2009, at 9:59 AM, Reynes Philippe wrote:

> You're right, there no space in "national,lm75".

in the future such comments are best placed after the ---.

- k

>
>
> Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
> ---
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/ 
> boot/dts/mpc8377_rdb.dts
> index e747486..54b4520 100644
> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -137,6 +137,11 @@
