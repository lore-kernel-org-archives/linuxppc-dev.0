Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0147.outbound.protection.outlook.com [157.56.111.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21F671A0332
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 08:52:41 +1000 (AEST)
Message-ID: <1428533547.22867.521.camel@freescale.com>
Subject: Re: [PATCH 3/4 v2] powerpc/fsl-booke: Add T1024 RDB board support
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Wed, 8 Apr 2015 17:52:27 -0500
In-Reply-To: <1428489987-31209-3-git-send-email-Shengzhou.Liu@freescale.com>
References: <1428489987-31209-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1428489987-31209-3-git-send-email-Shengzhou.Liu@freescale.com>
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
> T1024RDB is a Freescale Reference Design Board that hosts the T1024 SoC.
> 
> T1024RDB board Overview
> -----------------------
> - Processor: T1024 SoC integrating two 64-bit e5500 cores up to 1.4GHz
> - Memory: 64-bit 4GB DDR3L UDIMM with ECC and interleaving support
> - Ethernet: two 1G RGMII ports, one 2.5G SGMII port and one 10G Base-T port
> - Accelerator: DPAA components consist of FMan, BMan, QMan, PME, DCE and SEC
> - SerDes: 4 lanes up to 10.3125GHz
> - IFC: 128MB NOR Flash, 1GB NAND Flash and CPLD system controlling
> - PCIe: one PCIe slot and two Mini-PCIe connectors on-board
> - USB: two Type-A USB2.0 ports with internal PHY
> - eSDHC: one SDHC/MMC/eMMC connector
> - eSPI: one 64MB N25Q512 SPI flash
> - QE-TDM: support TDM Riser card
>    - 32-bit RISC controller for flexible support of the communications peripherals
>    - Serial DMA channel for receive and transmit on all serial channels
>    - Two universal communication controllers, supporting TDM, HDLC, and UART
> - I2C: four I2C controllers
> - UART: two UART on board
> - Deep sleep power management support
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> v2: Integrated scott's comments.

My comment was to add a binding for the QE TDM stuff, not to remove it.

-Scott
