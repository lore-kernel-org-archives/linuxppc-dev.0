Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 240C5DE046
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 01:33:45 +1000 (EST)
Message-Id: <3772A304-5235-44BE-9947-379375382BAF@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20090421011022.GA21422@yookeroo.seuss>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 2/5] powerpc: Add 36-bit device tree for mpc8641hpcn
Date: Tue, 21 Apr 2009 10:33:34 -0500
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
	<20090421011022.GA21422@yookeroo.seuss>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2009, at 8:10 PM, David Gibson wrote:

> On Mon, Apr 20, 2009 at 11:26:47AM -0500, Becky Bruce wrote:
>> The new dts places most of the devices in physical address space
>> above 32-bits, which allows us to have more than 4GB of RAM present.
>>
>> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
>> ---
>> arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts |  597 ++++++++++++++++++ 
>> ++++++++++
>> 1 files changed, 597 insertions(+), 0 deletions(-)
>> create mode 100644 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
>>
>> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts b/arch/ 
>> powerpc/boot/dts/mpc8641_hpcn_36b.dts
>> new file mode 100644
>> index 0000000..baa3dba
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
>> @@ -0,0 +1,597 @@
>> +/*
>> + * MPC8641 HPCN Device Tree Source
>> + *
>> + * Copyright 2006 Freescale Semiconductor Inc.
>> + *
>> + * This program is free software; you can redistribute  it and/or  
>> modify it
>> + * under  the terms of  the GNU General  Public License as  
>> published by the
>> + * Free Software Foundation;  either version 2 of the  License, or  
>> (at your
>> + * option) any later version.
>> + */
>
> [snip]
>> +	soc8641@fffe00000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		device_type = "soc";
>> +		compatible = "simple-bus";
>
> Uh, you definitely need something more specific in the compatible
> property before "simple-bus".

This is a copy of the existing mpc8641hpcn dts file, with just  
physical address changes, so if there's a problem here it definitely  
exists in the current 8641hpcn dts, and possibly other dts files as  
well.  I think the correct solution is for me to go look at that .dts  
(and any others that may be similar), and put out a followup to fix  
them all.

Thanks,
Becky
