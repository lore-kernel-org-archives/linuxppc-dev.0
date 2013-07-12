Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70BFF2C036A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 07:02:05 +1000 (EST)
Date: Fri, 12 Jul 2013 16:01:56 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V5] powerpc/85xx: add the P1020RDB-PD DTS support
To: Haijun Zhang <Haijun.Zhang@freescale.com>
References: <1373587738-29235-1-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1373587738-29235-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Thu Jul 11 19:08:58 2013)
Message-ID: <1373662916.8183.285@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, AFLEMING@freescale.com,
 Haijun Zhang <Haijun.Zhang@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Xie Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 07:08:58 PM, Haijun Zhang wrote:
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
> - 1 USB ports
> - TDM ports
> - PCIe
>=20
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Xie Xiaobo-R63061 <X.Xie@freescale.com>
> CC: Scott Wood <scottwood@freescale.com>
> ---
> changes for v5:
> 	- change the size of nand file system

What about the SPI filesystem?

-Scott=
