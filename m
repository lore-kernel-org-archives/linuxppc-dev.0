Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53CA5B7BF4
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:06:57 +1100 (EST)
Subject: Re: [PATCH 5/7] powerpc/85xx: Add power management support for
	MPC85xxMDS boards
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091105140407.GA16698@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 08:06:51 -0600
Message-Id: <39FA5DC3-BE71-442B-9EDC-2764D1391074@kernel.crashing.org>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214359.GE24821@oksana.dev.rtsoft.ru>
	<197B3989-3373-4172-B5FA-727CA1EEE2AA@kernel.crashing.org>
	<20091105140407.GA16698@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 5, 2009, at 8:04 AM, Anton Vorontsov wrote:

> On Thu, Nov 05, 2009 at 07:58:49AM -0600, Kumar Gala wrote:
> [...]
>> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
>> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
>> @@ -40,6 +40,8 @@
>> 			i-cache-line-size = <32>;	// 32 bytes
>> 			d-cache-size = <0x8000>;		// L1, 32K
>> 			i-cache-size = <0x8000>;		// L1, 32K
>> +			sleep = <&pmc 0x00008000	// core
>> +				 &pmc 0x00004000>;	// timebase
>>
>> Just so I'm clear this is the devdisr bit position?
>
> Yep, as described in the bindings.

I don't think the binding is clear that for 85xx these are DEVDISR bit  
positions for the given SoC.

- k
