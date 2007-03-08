Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8AAADDEB6
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 13:48:15 +1100 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
	<CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <011CC9FF-E609-43A1-BC66-C57CC6233B4B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Wed, 7 Mar 2007 20:47:20 -0600
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2007, at 7:56 PM, Zhang Wei-r63237 wrote:

> Hi, Kumar and Scott,
>
> Thanks for your review. :-)
>
> The MPC8641HPCN's RTC is a module of ULI1575, which is a legacy RTC
> device with operate by I/O ports 0x70 and 0x71. So I use functions
> defined in asm-generic/rtc.h to set and get rtc time.

Than you need to include <linux/mc146818rtc.h> in the file to get the  
CMOS_* defn.

- k
