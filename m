Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29B62DDFE6
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 01:03:42 +1000 (EST)
Message-Id: <DA55CC6B-F9AC-4ACB-A704-D61CCEB98023@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Chen Gong <g.chen@freescale.com>
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC2F16798@zch01exm21.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/6] [WATCHDOG] mpc83xx_wdt: rename to mpc8xxx_wdt
Date: Wed, 14 May 2008 10:03:16 -0500
References: <20080513141411.GA8981@polina.dev.rtsoft.ru><20080513141459.GC15717@polina.dev.rtsoft.ru>
	<20080514114523.ae20b0da.sfr@canb.auug.org.au>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F16798@zch01exm21.fsl.freescale.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Wood Scott <scottwood@freescale.com>,
	Tabi Timur <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 13, 2008, at 10:53 PM, Chen Gong wrote:

>
>
>> -----Original Message-----
>> From: linuxppc-dev-bounces+b11801=freescale.com@ozlabs.org
>> [mailto:linuxppc-dev-bounces+b11801=freescale.com@ozlabs.org]
>> On Behalf Of Stephen Rothwell
>> Sent: 2008?5?14? 9:45
>> To: Anton Vorontsov
>> Cc: Wood Scott; linuxppc-dev@ozlabs.org; Wim Van Sebroeck; Tabi Timur
>> Subject: Re: [PATCH 3/6] [WATCHDOG] mpc83xx_wdt: rename to  
>> mpc8xxx_wdt
>>
>> On Tue, 13 May 2008 18:14:59 +0400 Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>>>
>>> Rename the driver because now we support some MPC86xx processors.
> What I want to know is that what about watchdog for booke(85xx) ?

what about it, its still there in the tree (booke_wdt.c).  This driver  
is for a SoC level watchdog that exists on 8xx, 83xx and 8610.

- k
