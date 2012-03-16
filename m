Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 304ABB6FD8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:07:10 +1100 (EST)
Subject: Re: [PATCH 2/2 v4] powerpc/dts: Add dts for p1025rdb board
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXWPbH7s=_LsvEnd_p8wrgH2LKWXV8Xi8NgjF_dC_8zqfw@mail.gmail.com>
Date: Fri, 16 Mar 2012 10:07:03 -0500
Message-Id: <AA0EEBAB-1EBE-4BF4-8EE2-B6D273DE8E12@kernel.crashing.org>
References: <1329206783-12190-1-git-send-email-B32736@freescale.com>
 <1329206783-12190-2-git-send-email-B32736@freescale.com>
 <CAOZdJXWPbH7s=_LsvEnd_p8wrgH2LKWXV8Xi8NgjF_dC_8zqfw@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fan Zhicheng-B32736 <B32736@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 16, 2012, at 3:06 PM, Tabi Timur-B04825 wrote:

> On Tue, Feb 14, 2012 at 2:06 AM, Zhicheng Fan <B32736@freescale.com> wrote:
>> From: Zhicheng Fan <b32736@freescale.com>
>> 
>> P1025RDB Overview
>> ------------------
>> 1Gbyte DDR3 SDRAM
>> 32 Mbyte NAND flash
>> 16Mbyte NOR flash
>> 16 Mbyte SPI flash
>> SD connector to interface with the SD memory card
>> Real-time clock on I2C bus
>> 
>> PCIe:
>> - x1 PCIe slot
>> - x1 mini-PCIe slot
>> 
>> 10/100/1000 BaseT Ethernet ports:
>> - eTSEC1, RGMII: one 10/100/1000 port using AtherosTM AR8021
>> - eTSEC2, SGMII: one 10/100/1000 port using VitesseTM VSC8221
>> - eTSEC3, RGMII: one 10/100/1000 port using AtherosTM AR8021
>> 
>> USB 2.0 port:
>> - Two USB2.0 Type A receptacles
>> - One USB2.0 signal to Mini PCIe slot
>> 
>> Dual RJ45 UART ports:
>> - DUART interface: supports two UARTs up to 115200 bps for console display
>> 
>> Signed-off-by: Zhicheng Fan <b32736@freescale.com>
>> ---
> 
> Acked-by: Timur Tabi <timur@freescale.com>

applied

- k
