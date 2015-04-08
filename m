Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0115.outbound.protection.outlook.com [207.46.100.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4855C1A086D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 08:52:47 +1000 (AEST)
Message-ID: <1428533550.22867.522.camel@freescale.com>
Subject: Re: [PATCH 1/4 v2] powerpc/fsl-booke: Add device tree support for
 T1024/T1023 SoC
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Wed, 8 Apr 2015 17:52:30 -0500
In-Reply-To: <1428489987-31209-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1428489987-31209-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-08 at 18:46 +0800, Shengzhou Liu wrote:
> The T1024 SoC includes the following function and features:
> - Two 64-bit Power architecture e5500 cores, up to 1.4GHz
> - private 256KB L2 cache each core and shared 256KB CoreNet platform cache (CPC)
> - 32-/64-bit DDR3L/DDR4 SDRAM memory controller with ECC and interleaving support
> - Data Path Acceleration Architecture (DPAA) incorporating acceleration
> - Four MAC for 1G/2.5G/10G network interfaces (RGMII, SGMII, QSGMII, XFI)
> - High-speed peripheral interfaces
>   - Three PCI Express 2.0 controllers
> - Additional peripheral interfaces
>   - One SATA 2.0 controller
>   - Two USB 2.0 controllers with integrated PHY
>   - Enhanced secure digital host controller (SD/eSDHC/eMMC)
>   - Enhanced serial peripheral interface (eSPI)
>   - Four I2C controllers
>   - Four 2-pin UARTs or two 4-pin UARTs
>   - Integrated Flash Controller supporting NAND and NOR flash
> - Two 8-channel DMA engines
> - Multicore programmable interrupt controller (PIC)
> - LCD interface (DIU) with 12 bit dual data rate
> - QUICC Engine block supporting TDM, HDLC, and UART
[snip]
> +&soc {
> +/include/ "qoriq-tdm1.0.dtsi"

Where is this file?  Is there some dependency you've forgotten to
mention?

If this is meant to apply after
http://patchwork.ozlabs.org/patch/457605/
is that really QUICC engine TDM as described in the comment above?

-Scott
