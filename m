Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA158DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 05:35:48 +1100 (EST)
Message-Id: <4E174FEE-CFF8-4E27-BD6B-4B0557A4E0E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20081021182344.GA22232@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] powerpc/83xx: add DS1339 RTC support for
	MPC8349E-mITX boards
Date: Tue, 21 Oct 2008 13:35:37 -0500
References: <20081017185659.GA30008@oksana.dev.rtsoft.ru>
	<20081021182344.GA22232@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 21, 2008, at 1:23 PM, Scott Wood wrote:

> On Fri, Oct 17, 2008 at 10:56:59PM +0400, Anton Vorontsov wrote:
>> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/ 
>> boot/dts/mpc8349emitx.dts
>> index 5cedf37..7fc5414 100644
>> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
>> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
>> @@ -83,6 +83,14 @@
>> 			interrupts = <15 0x8>;
>> 			interrupt-parent = <&ipic>;
>> 			dfsrr;
>> +
>> +			rtc@68 {
>> +				device_type = "rtc";
>> +				compatible = "dallas,ds1339";
>> +				reg = <0x68>;
>> +				interrupts = <18 0x8>;
>> +				interrupt-parent = <&ipic>;
>> +			};
>
> Why are we adding more device_types?

I think the 'rtc' device_type is legacy from OF.

- k
