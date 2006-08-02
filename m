Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DDAB67C9A
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 06:07:43 +1000 (EST)
In-Reply-To: <44D0FDF3.4020401@ru.mvista.com>
References: <1154544503.19994.42.camel@cashmere.sps.mot.com>
	<9C1B15CC-6984-433D-8A1E-F856567B1AD2@kernel.crashing.org>
	<44D0FDF3.4020401@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <14529070-43FA-476C-9459-02159E5550D9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add MPC8641 HPCN Device Tree Source file.
Date: Wed, 2 Aug 2006 15:07:43 -0500
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 2, 2006, at 2:33 PM, Sergei Shtylyov wrote:

> Hello.
>
> Kumar Gala wrote:
>> Do we want to go ahead and fix the mac address field having the  
>> wrong  name?
>
>    If you mean "address" instead of "local-mac-address" then I  
> guess Documentation/powerpc/booting-without-of.txt should also be  
> changed since it has "address". And arch/powerpc/sysdev/fsl_soc.c  
> as well..

Yeah, fsl_soc.c should be updated to support both forms for a period  
of time.

- kumar

>>> +		ethernet@24000 {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			device_type = "network";
>>> +			model = "TSEC";
>>> +			compatible = "gianfar";
>>> +			reg = <24000 1000>;
>>> +			address = [ 00 E0 0C 00 73 00 ];
>>> +			interrupts = <1d 2 1e 2 22 2>;
>>> +			interrupt-parent = <40000>;
>>> +			phy-handle = <2452000>;
>>> +		};
>>> +
>>> +		ethernet@25000 {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			device_type = "network";
>>> +			model = "TSEC";
>>> +			compatible = "gianfar";
>>> +			reg = <25000 1000>;
>>> +			address = [ 00 E0 0C 00 73 01 ];
>>> +			interrupts = <23 2 24 2 28 2>;
>>> +			interrupt-parent = <40000>;
>>> +			phy-handle = <2452001>;
>>> +		};
>>> +		
>>> +		ethernet@26000 {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			device_type = "network";
>>> +			model = "TSEC";
>>> +			compatible = "gianfar";
>>> +			reg = <26000 1000>;
>>> +			address = [ 00 E0 0C 00 02 FD ];
>>> +			interrupts = <1F 2 20 2 21 2>;
>>> +			interrupt-parent = <40000>;
>>> +			phy-handle = <2452002>;
>>> +		};
>>> +
>>> +		ethernet@27000 {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			device_type = "network";
>>> +			model = "TSEC";
>>> +			compatible = "gianfar";
>>> +			reg = <27000 1000>;
>>> +			address = [ 00 E0 0C 00 03 FD ];
>>> +			interrupts = <25 2 26 2 27 2>;
>>> +			interrupt-parent = <40000>;
>>> +			phy-handle = <2452003>;
>>> +		};
>
> WBR, Sergei
