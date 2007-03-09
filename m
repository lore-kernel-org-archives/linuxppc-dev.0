Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3FFADDEAB
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 15:53:10 +1100 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C131B5F@zch01exm26.fsl.freescale.net>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<20070307193438.GA30721@ld0162-tx32.am.freescale.net>
	<CBC6BDF5-EB84-463C-A53C-1204CC396D5F@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE14@zch01exm26.fsl.freescale.net>
	<011CC9FF-E609-43A1-BC66-C57CC6233B4B@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE68@zch01exm26.fsl.freescale.net>
	<1AEDE9F3-E4D4-4BB8-A0C7-D7D82BE29A4C@kernel.crashing.org>
	<1173381017.23776.211.camel@ld0161-tx32>
	<1173381543.2968.10.camel@udp097531uds.am.freescale.net>
	<82D7F244-A949-4DC9-8DE3-A91DD25CD50A@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C131B07@zch01exm26.fsl.freescale.net>
	<53280A91-C40D-4E01-8DA3-D1D9B1C40A61@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C131B5F@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DFDB8D99-C0C2-4884-95F8-98DC8C172A60@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Thu, 8 Mar 2007 22:52:10 -0600
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Wang Haiying-r54964 <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 8, 2007, at 10:23 PM, Zhang Wei-r63237 wrote:

>>> Please use 80.
>>> We reserve the first 16 ints for legacy 8259 interrupts. And we
>>> want the
>>> virq is the same value to hw-irq.
>>
>> Why?
>
> If the virq equals hw-irq, it's clear and simple to user.

I don't think that's a good reason to over allocate.

There's a reason we have virtual IRQs now.  Its specifically to deal  
with issues like the 16 interrupts for 8259 and not have to do games  
to offset IRQs.

If we needed create some debugfs or sysfs info that translates VIRQ  
to HW irq

- k
