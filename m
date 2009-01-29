Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1ACFDDF4F
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 06:23:40 +1100 (EST)
Message-Id: <0819EFA5-E86A-4D7F-8C60-06721B8072D8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090129192031.GA17060@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] add gpio to mpc837X rdb
Date: Thu, 29 Jan 2009 13:23:24 -0600
References: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
	<20090129192031.GA17060@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Reynes Philippe <philippe.reynes@isismpp.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2009, at 1:20 PM, Anton Vorontsov wrote:

> On Thu, Jan 29, 2009 at 06:37:15PM +0100, Reynes Philippe wrote:
>> Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
>> ---
>> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts
>> b/arch/powerpc/boot/dts/mpc8377_rdb.dts
>> index 165463f..45c9f03 100644
>> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
>> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
>> @@ -109,6 +109,24 @@
>> 			reg = <0x200 0x100>;
>> 		};
>>
>> +		gpio1: gpio-controller@c00 {
>> +			#gpio-cells = <2>;
>> +			compatible = "fsl,mpc8347-gpio",
>
> I think this should be "fsl,mpc8377-gpio", "fsl,mpc8349-gpio".
>
> [...]
>> --- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
>> +++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
>> @@ -109,6 +109,24 @@
>> 			reg = <0x200 0x100>;
>> 		};
>>
>> +		gpio1: gpio-controller@c00 {
>> +			#gpio-cells = <2>;
>> +			compatible = "fsl,mpc8347-gpio",
>> "fsl,mpc8349-gpio";
>
> "fsl,mpc8378-gpio", "fsl,mpc8349-gpio".
>
> [...]
>> --- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
>> +++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
>> @@ -107,6 +107,24 @@
>> 			reg = <0x200 0x100>;
>> 		};
>>
>> +		gpio1: gpio-controller@c00 {
>> +			#gpio-cells = <2>;
>> +			compatible = "fsl,mpc8347-gpio",
>> "fsl,mpc8349-gpio";
>
> "fsl,mpc8379-gpio", "fsl,mpc8349-gpio".

Agreed w/Anton here.

- k
