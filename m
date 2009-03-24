Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99407DDED4
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 04:43:09 +1100 (EST)
Message-Id: <FE66BF2D-4F61-412A-BC04-7402EE0FC1F3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090324160032.GB24778@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/83xx: Update ranges in gianfar node to match
	other dts
Date: Tue, 24 Mar 2009 12:42:57 -0500
References: <1237901745-27418-1-git-send-email-galak@kernel.crashing.org>
	<20090324160032.GB24778@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 24, 2009, at 11:00 AM, Scott Wood wrote:

> On Tue, Mar 24, 2009 at 08:35:45AM -0500, Kumar Gala wrote:
>> The gianfar node @ 25000 was missing its ranges prop for the mdio bus
>> and provided an explicit ranges property on gianfar@24000 to match
>> all other .dts
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> arch/powerpc/boot/dts/mpc8313erdb.dts |    3 ++-
>> 1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/ 
>> boot/dts/mpc8313erdb.dts
>> index 3ebf7ec..20a0fa8 100644
>> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
>> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
>> @@ -180,7 +180,7 @@
>> 			#address-cells = <1>;
>> 			#size-cells = <1>;
>> 			sleep = <&pmc 0x20000000>;
>> -			ranges;
>> +			ranges = <0x0 0x24000 0x1000>;
>>
>> 			cell-index = <0>;
>> 			device_type = "network";
>
> You need to fix the reg property of the child node to match this  
> change
> in ranges.  Was this boot-tested (or is it a case of Linux's device  
> tree
> parsing being excessively tolerant of broken trees)?
>
I didn't boot test.. Anton pointed this issue out as well.

- k
