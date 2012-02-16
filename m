Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EEEB1B6FD6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 08:06:55 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Fan Zhicheng-B32736 <B32736@freescale.com>
Subject: Re: [PATCH 2/2 v4] powerpc/dts: Add dts for p1025rdb board
Date: Thu, 16 Feb 2012 21:06:48 +0000
Message-ID: <CAOZdJXWPbH7s=_LsvEnd_p8wrgH2LKWXV8Xi8NgjF_dC_8zqfw@mail.gmail.com>
References: <1329206783-12190-1-git-send-email-B32736@freescale.com>
 <1329206783-12190-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1329206783-12190-2-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 14, 2012 at 2:06 AM, Zhicheng Fan <B32736@freescale.com> wrote:
> From: Zhicheng Fan <b32736@freescale.com>
>
> P1025RDB Overview
> ------------------
> 1Gbyte DDR3 SDRAM
> 32 Mbyte NAND flash
> 16Mbyte NOR flash
> 16 Mbyte SPI flash
> SD connector to interface with the SD memory card
> Real-time clock on I2C bus
>
> PCIe:
> - x1 PCIe slot
> - x1 mini-PCIe slot
>
> 10/100/1000 BaseT Ethernet ports:
> - eTSEC1, RGMII: one 10/100/1000 port using AtherosTM AR8021
> - eTSEC2, SGMII: one 10/100/1000 port using VitesseTM VSC8221
> - eTSEC3, RGMII: one 10/100/1000 port using AtherosTM AR8021
>
> USB 2.0 port:
> - Two USB2.0 Type A receptacles
> - One USB2.0 signal to Mini PCIe slot
>
> Dual RJ45 UART ports:
> - DUART interface: supports two UARTs up to 115200 bps for console displa=
y
>
> Signed-off-by: Zhicheng Fan <b32736@freescale.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>

--=20
Timur Tabi
Linux kernel developer at Freescale=
