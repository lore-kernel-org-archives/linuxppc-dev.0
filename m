Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C31ADDE37
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 17:24:26 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Fix L1 cache size in katmai DTS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1203607297-15732-1-git-send-email-sr@denx.de>
References: <1203607297-15732-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 17:24:01 +1100
Message-Id: <1203661441.10422.287.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-02-21 at 16:21 +0100, Stefan Roese wrote:
> This patch changes the katmai (440SPe) L1 cache size to 32k. Some
> whitespace issues are cleaned up too.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

Ack.

> ---
>  arch/powerpc/boot/dts/katmai.dts |   58 +++++++++++++++++++-------------------
>  1 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
> index 9bdfc0f..abf7f3e 100644
> --- a/arch/powerpc/boot/dts/katmai.dts
> +++ b/arch/powerpc/boot/dts/katmai.dts
> @@ -38,8 +38,8 @@
>  			timebase-frequency = <0>; /* Filled in by zImage */
>  			i-cache-line-size = <20>;
>  			d-cache-line-size = <20>;
> -			i-cache-size = <20000>;
> -			d-cache-size = <20000>;
> +			i-cache-size = <8000>;
> +			d-cache-size = <8000>;
>  			dcr-controller;
>  			dcr-access-method = "native";
>  		};
> @@ -136,11 +136,11 @@
>  		};
>  
>  		POB0: opb {
> -		  	compatible = "ibm,opb-440spe", "ibm,opb-440gp", "ibm,opb";
> +			compatible = "ibm,opb-440spe", "ibm,opb-440gp", "ibm,opb";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -		  	ranges = <00000000 4 e0000000 20000000>;
> -		  	clock-frequency = <0>; /* Filled in by zImage */
> +			ranges = <00000000 4 e0000000 20000000>;
> +			clock-frequency = <0>; /* Filled in by zImage */
>  
>  			EBC0: ebc {
>  				compatible = "ibm,ebc-440spe", "ibm,ebc-440gp", "ibm,ebc";
> @@ -153,38 +153,38 @@
>  			};
>  
>  			UART0: serial@10000200 {
> -		   		device_type = "serial";
> -		   		compatible = "ns16550";
> -		   		reg = <10000200 8>;
> +				device_type = "serial";
> +				compatible = "ns16550";
> +				reg = <10000200 8>;
>  				virtual-reg = <a0000200>;
> -		   		clock-frequency = <0>; /* Filled in by zImage */
> -		   		current-speed = <1c200>;
> -		   		interrupt-parent = <&UIC0>;
> -		   		interrupts = <0 4>;
> -	   		};
> +				clock-frequency = <0>; /* Filled in by zImage */
> +				current-speed = <1c200>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <0 4>;
> +			};
>  
>  			UART1: serial@10000300 {
> -		   		device_type = "serial";
> -		   		compatible = "ns16550";
> -		   		reg = <10000300 8>;
> +				device_type = "serial";
> +				compatible = "ns16550";
> +				reg = <10000300 8>;
>  				virtual-reg = <a0000300>;
> -		   		clock-frequency = <0>;
> -		   		current-speed = <0>;
> -		   		interrupt-parent = <&UIC0>;
> -		   		interrupts = <1 4>;
> -	   		};
> +				clock-frequency = <0>;
> +				current-speed = <0>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <1 4>;
> +			};
>  
> 
>  			UART2: serial@10000600 {
> -		   		device_type = "serial";
> -		   		compatible = "ns16550";
> -		   		reg = <10000600 8>;
> +				device_type = "serial";
> +				compatible = "ns16550";
> +				reg = <10000600 8>;
>  				virtual-reg = <a0000600>;
> -		   		clock-frequency = <0>;
> -		   		current-speed = <0>;
> -		   		interrupt-parent = <&UIC1>;
> -		   		interrupts = <5 4>;
> -	   		};
> +				clock-frequency = <0>;
> +				current-speed = <0>;
> +				interrupt-parent = <&UIC1>;
> +				interrupts = <5 4>;
> +			};
>  
>  			IIC0: i2c@10000400 {
>  				device_type = "i2c";
