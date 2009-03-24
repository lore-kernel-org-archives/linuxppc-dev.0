Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2871DDF1E
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 01:24:46 +1100 (EST)
Message-Id: <416D545E-14C4-4BD8-A7D6-C66CC2F92F1F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090324142045.GA17184@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/83xx: Update ranges in gianfar node to match
	other dts
Date: Tue, 24 Mar 2009 09:24:39 -0500
References: <1237901745-27418-1-git-send-email-galak@kernel.crashing.org>
	<20090324142045.GA17184@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 24, 2009, at 9:20 AM, Anton Vorontsov wrote:

> On Tue, Mar 24, 2009 at 08:35:45AM -0500, Kumar Gala wrote:
>> The gianfar node @ 25000 was missing its ranges prop for the mdio bus
>> and provided an explicit ranges property on gianfar@24000 to match
>> all other .dts
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>
> I think this part is missing:
>
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/ 
> boot/dts/mpc8313erdb.dts
> index 3ebf7ec..98de8bf 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -195,11 +195,11 @@
> 			fixed-link = <1 1 1000 0 0>;
> 			fsl,magic-packet;
>
> -			mdio@24520 {
> +			mdio@520 {
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 				compatible = "fsl,gianfar-mdio";
> -				reg = <0x24520 0x20>;
> +				reg = <0x520 0x20>;
> 				phy4: ethernet-phy@4 {
> 					interrupt-parent = <&ipic>;
> 					interrupts = <20 0x8>;
> @@ -229,11 +229,11 @@
> 			sleep = <&pmc 0x10000000>;
> 			fsl,magic-packet;
>
> -			mdio@25520 {
> +			mdio@520 {
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 				compatible = "fsl,gianfar-tbi";
> -				reg = <0x25520 0x20>;
> +				reg = <0x520 0x20>;
>
> 				tbi1: tbi-phy@11 {
> 					reg = <0x11>;
>>

yep, sending a new version

- k
