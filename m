Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E86E3DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 17:26:52 +1100 (EST)
Message-ID: <47D4D652.4080902@denx.de>
Date: Mon, 10 Mar 2008 07:33:54 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [Patch] 8xx: MGSUVD support
References: <47D3B44D.8070909@denx.de>
	<20080309195914.69d51e68@kernel.crashing.org>
In-Reply-To: <20080309195914.69d51e68@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Vitaly,

Vitaly Bordug wrote:
> Heiko Schocher wrote:
>> the following patch adds support for the MPC852 based mgsuvd board
>> from keymile.
> Looks good overall. Please add supported/working/not working etc SoC devices state along with the patch 
> description. Also a few really small comments below...

OK.

>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
[...]
>> +
>> +		PowerPC,866@0 {
> But it's mpc852, isn't it?

Yes your are right.

>> +			device_type = "cpu";
>> +			reg = <0>;
>> +			d-cache-line-size = <d#16>;
>> +			i-cache-line-size = <d#16>;
>> +			d-cache-size = <d#8192>;
>> +			i-cache-size = <d#8192>;
>> +			timebase-frequency = <0>;  /* Filled in by
>> u-boot */
>> +			bus-frequency = <0>;  /* Filled in by u-boot
>> */
>> +			clock-frequency = <0>; /* Filled in by
>> u-boot */
>> +			interrupts = <f 2>;	// decrementer
>> interrupt
> I would like all the comments to be consistent C style (because that's it for the most other dts'es).

Okay, I fix this, and send a new patch.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
