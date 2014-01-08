Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1495E2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 12:01:57 +1100 (EST)
Date: Tue, 7 Jan 2014 19:01:37 -0600
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Subject: Re: [V6,2/2] powerpc/85xx: Add TWR-P1025 board support
Message-ID: <20140108010134.GA10504@home.buserror.net>
References: <1383728883-25561-2-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1383728883-25561-2-git-send-email-X.Xie@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Michael Johnston <michael.johnston@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 06, 2013 at 05:08:03PM +0800, Xie Xiaobo wrote:
> TWR-P1025 Overview
>  -----------------
>  512Mbyte DDR3 (on board DDR)
>  64MB Nor Flash
>  eTSEC1: Connected to RGMII PHY AR8035
>  eTSEC3: Connected to RGMII PHY AR8035
>  Two USB2.0 Type A
>  One microSD Card slot
>  One mini-PCIe slot
>  One mini-USB TypeB dual UART
> 
> Signed-off-by: Michael Johnston <michael.johnston@freescale.com>
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> 
> ---
> Patch V6: Add a binding doc for ssd1289 device.
> Patch V5: Miscellaneous modification. e.g. move the qe ucc node into dtsi.
> Patch V4: Fix the mdio phy interrupt issue in dts
> Patch V3: fix pcie range issue in dts
> Patch V2: QE related init codes were factored out to a common file
> 
>  .../devicetree/bindings/video/ssd1289fb.txt        |  13 +
>  arch/powerpc/boot/dts/p1025twr.dts                 |  95 +++++++
>  arch/powerpc/boot/dts/p1025twr.dtsi                | 280 +++++++++++++++++++++
>  arch/powerpc/platforms/85xx/Kconfig                |   6 +
>  arch/powerpc/platforms/85xx/Makefile               |   1 +
>  arch/powerpc/platforms/85xx/twr_p102x.c            | 147 +++++++++++

No mpc85xx_smp_defconfig update?

-Scott
