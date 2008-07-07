Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C259ADDDE9
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 05:52:29 +1000 (EST)
Message-ID: <48727374.1010304@ru.mvista.com>
Date: Mon, 07 Jul 2008 23:50:12 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH v5] ibm_newemac: Parameterize EMAC Multicast Match Handling
References: <1215303343-26410-1-git-send-email-gerickson@nuovations.com>
	<1215387012-6464-1-git-send-email-gerickson@nuovations.com>
In-Reply-To: <1215387012-6464-1-git-send-email-gerickson@nuovations.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Erickson wrote:

<snip>

> index 48c9a6e..799592d 100644
> --- a/arch/powerpc/boot/dts/kilauea.dts
> +++ b/arch/powerpc/boot/dts/kilauea.dts
> @@ -205,7 +205,7 @@
>  			EMAC0: ethernet@ef600900 {
>  				linux,network-index = <0>;
>  				device_type = "network";
> -				compatible = "ibm,emac-405ex", "ibm,emac4";
> +				compatible = "ibm,emac-405ex", "ibm,emac4sync";
>  				interrupt-parent = <&EMAC0>;
>  				interrupts = <0 1>;
>  				#interrupt-cells = <1>;
> @@ -213,7 +213,7 @@
>  				#size-cells = <0>;
>  				interrupt-map = </*Status*/ 0 &UIC0 18 4
>  						/*Wake*/  1 &UIC1 1d 4>;
> -				reg = <ef600900 70>;
> +				reg = <ef600900 c4>;
>  				local-mac-address = [000000000000]; /* Filled in by U-Boot */
>  				mal-device = <&MAL0>;
>  				mal-tx-channel = <0>;
> @@ -233,7 +233,7 @@
>  			EMAC1: ethernet@ef600a00 {
>  				linux,network-index = <1>;
>  				device_type = "network";
> -				compatible = "ibm,emac-405ex", "ibm,emac4";
> +				compatible = "ibm,emac-405ex", "ibm,emac4sync";
>  				interrupt-parent = <&EMAC1>;
>  				interrupts = <0 1>;
>  				#interrupt-cells = <1>;
> @@ -241,7 +241,7 @@
>  				#size-cells = <0>;
>  				interrupt-map = </*Status*/ 0 &UIC0 19 4
>  						/*Wake*/  1 &UIC1 1f 4>;
> -				reg = <ef600a00 70>;
> +				reg = <ef600900 c4>;

Should be reg = <ef600a00 c4>

<snip>

> --- a/arch/powerpc/boot/dts/makalu.dts
> +++ b/arch/powerpc/boot/dts/makalu.dts
> @@ -205,7 +205,7 @@
>  			EMAC0: ethernet@ef600900 {
>  				linux,network-index = <0>;
>  				device_type = "network";
> -				compatible = "ibm,emac-405ex", "ibm,emac4";
> +				compatible = "ibm,emac-405ex", "ibm,emac4sync";
>  				interrupt-parent = <&EMAC0>;
>  				interrupts = <0 1>;
>  				#interrupt-cells = <1>;
> @@ -213,7 +213,7 @@
>  				#size-cells = <0>;
>  				interrupt-map = </*Status*/ 0 &UIC0 18 4
>  						/*Wake*/  1 &UIC1 1d 4>;
> -				reg = <ef600900 70>;
> +				reg = <ef600900 c4>;
>  				local-mac-address = [000000000000]; /* Filled in by U-Boot */
>  				mal-device = <&MAL0>;
>  				mal-tx-channel = <0>;
> @@ -233,7 +233,7 @@
>  			EMAC1: ethernet@ef600a00 {
>  				linux,network-index = <1>;
>  				device_type = "network";
> -				compatible = "ibm,emac-405ex", "ibm,emac4";
> +				compatible = "ibm,emac-405ex", "ibm,emac4sync";
>  				interrupt-parent = <&EMAC1>;
>  				interrupts = <0 1>;
>  				#interrupt-cells = <1>;
> @@ -241,7 +241,7 @@
>  				#size-cells = <0>;
>  				interrupt-map = </*Status*/ 0 &UIC0 19 4
>  						/*Wake*/  1 &UIC1 1f 4>;
> -				reg = <ef600a00 70>;
> +				reg = <ef600900 c4>;

Should be reg = <ef600a00 c4>


Thanks,
Valentine.
