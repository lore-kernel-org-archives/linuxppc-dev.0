Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (unknown
 [207.46.163.203]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 81EAE14007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 08:29:17 +1000 (EST)
Message-ID: <1397514507.20280.223.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: Add OCA4080 board support
From: Scott Wood <scottwood@freescale.com>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Date: Mon, 14 Apr 2014 17:28:27 -0500
In-Reply-To: <1397478910-26361-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
References: <1397478910-26361-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: stef.van.os@prodrive-technologies.com,
 Martijn de Gouw <martijn.de.gouw@prodrive.nl>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-14 at 14:35 +0200, Martijn de Gouw wrote:
> +	lbc: localbus@ffe124000 {
> +		reg = <0xf 0xfe124000 0 0x1000>;
> +		ranges = <0 0 0xf 0xef800000 0x800000>;
> +
> +		flash@0,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "cfi-flash";
> +			reg = <0 0 0x00800000>;
> +			bank-width = <2>;
> +			device-width = <2>;
> +			partition@rcw {
> +				label = "rcw";
> +				reg = <0x00000000 0x00020000>;
> +			};
> +			partition@fman-ucode {
> +				label = "fman-ucode";
> +				reg = <0x00020000 0x00020000>;
> +			};
> +			partition@user {
> +				label = "user";
> +				reg = <0x00040000 0x00680000>;
> +			};
> +			partition@env0 {
> +				label = "env0";
> +				reg = <0x006c0000 0x00020000>;
> +			};
> +			partition@env1 {
> +				label = "env1";
> +				reg = <0x006e0000 0x00020000>;
> +			};
> +			partition@u-boot {
> +				label = "u-boot";
> +				reg = <0x00700000 0x00080000>;
> +			};
> +			partition@u-boot-backup {
> +				label = "u-boot-backup";
> +				reg = <0x00780000 0x00080000>;
> +			};

These are not valid unit addresses.  Regardless, please don't put
partition info in the dts.

-Scott
