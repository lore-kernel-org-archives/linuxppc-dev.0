Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D6CE32C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 05:10:29 +1000 (EST)
Date: Wed, 3 Jul 2013 14:09:32 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: add the P1020RDB-PD DTS support
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1372651943-12045-1-git-send-email-Haijun.Zhang@freescale.com>
 <1372651943-12045-2-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1372651943-12045-2-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Sun Jun 30 23:12:23 2013)
Message-ID: <1372878572.8183.145@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "Haijun.Zhang" <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2013 11:12:23 PM, Haijun Zhang wrote:
> From: "Haijun.Zhang" <Haijun.Zhang@freescale.com>
>=20
> Overview of P1020RDB-PD device:
> - DDR3 2GB
> - NOR flash 64MB
> - NAND flash 128MB
> - SPI flash 16MB
> - I2C EEPROM 256Kb
> - eTSEC1 (RGMII PHY) connected to VSC7385 L2 switch
> - eTSEC2 (SGMII PHY)
> - eTSEC3 (RGMII PHY)
> - SDHC
> - 2 USB ports
> - 4 TDM ports
> - PCIe
>=20
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/dts/p1020rdb-pd.dtsi    | 257 =20
> ++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/p1020rdb-pd_32b.dts |  90 +++++++++++
>  2 files changed, 347 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd.dtsi
>  create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd_32b.dts

What about 36b?

> +	cpld@2,0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "cpld";
> +		reg =3D <0x2 0x0 0x20000>;
> +		read-only;
> +	};

Where does "cpld" as a compatible come from (it's way too vague)?  What =20
is read-only supposed to mean here?

Why do you have #address-cells/#size-cells if there are no child nodes?

-Scott=
