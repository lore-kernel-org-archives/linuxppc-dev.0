Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id DA618DDEED
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 03:31:17 +1000 (EST)
Message-ID: <4640B4AD.9020303@mvista.com>
Date: Tue, 08 May 2007 10:34:37 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: add dts entries to 85xx for EDAC
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
	<20070501183220.GA6426@blade.az.mvista.com>
	<20070507232634.GA11166@blade.az.mvista.com>
	<20070508034247.GA13409@lixom.net>
In-Reply-To: <20070508034247.GA13409@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Hi,
> 
>> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
>> index f261d64..f411bc1 100644
>> --- a/arch/powerpc/boot/dts/mpc8540ads.dts
>> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts
>> @@ -48,6 +48,22 @@
>>  		reg = <e0000000 00100000>;	// CCSRBAR 1M
>>  		bus-frequency = <0>;
>>  
>> +		memory-controller@2000 {
>> +			compatible = "fsl,85xx-memory-controller";
>> +			reg = <2000 1000>;
>> +			interrupt-parent = <&mpic>;
>> +			interrupts = <2 2>;
>> +		};
>> +
>> +		l2-cache-controller@20000 {
>> +			compatible = "fsl,85xx-memory-controller";
> 
> Interesting. Is the programming model really the same for the memory and cache controller?
> 
> 
> -Olof

That's an oops on my part. Thanks for pointing it out.


---

-= Dave =-
