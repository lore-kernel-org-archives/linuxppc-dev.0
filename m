Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C59C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:11:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55F121908
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55F121908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MBrJ3wDtzDqW8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 15:11:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MBp26jj0zDqW8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 15:09:14 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gaYYv-0000Ss-FL; Fri, 21 Dec 2018 22:06:54 -0600
Message-ID: <6a64c160360bae80a4908d3ca7a887d0c0cb35c9.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Camelia Groza <camelia.groza@nxp.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, benh@kernel.crashing.org
Date: Fri, 21 Dec 2018 22:06:52 -0600
In-Reply-To: <6fa5aa04d257525c5703b7c8ca833ec0ae0047c7.1531903211.git.camelia.groza@nxp.com>
References: <cover.1531903211.git.camelia.groza@nxp.com>
 <6fa5aa04d257525c5703b7c8ca833ec0ae0047c7.1531903211.git.camelia.groza@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: camelia.groza@nxp.com, robh+dt@kernel.org,
 mark.rutland@arm.com, benh@kernel.crashing.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 2/3] powerpc/dts/fsl: t4240rdb: use the Cortina PHY
 driver compatible
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-07-18 at 14:46 +0300, Camelia Groza wrote:
> The Cortina PHY requires the use of the dedicated Cortina PHY driver
> instead of the generic one.
> 
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
> ---
>  arch/powerpc/boot/dts/fsl/t4240rdb.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> index 15eb0a3..a56a705 100644
> --- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> +++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> @@ -267,22 +267,22 @@
>  
>  			mdio@fd000 {
>  				xfiphy1: ethernet-phy@10 {
> -					compatible = "ethernet-phy-ieee802.3-
> c45";
> +					compatible = "ethernet-phy-
> id13e5.1002";
>  					reg = <0x10>;
>  				};
>  
>  				xfiphy2: ethernet-phy@11 {
> -					compatible = "ethernet-phy-ieee802.3-
> c45";
> +					compatible = "ethernet-phy-
> id13e5.1002";
>  					reg = <0x11>;
>  				};
>  
>  				xfiphy3: ethernet-phy@13 {
> -					compatible = "ethernet-phy-ieee802.3-
> c45";
> +					compatible = "ethernet-phy-
> id13e5.1002";
>  					reg = <0x13>;
>  				};
>  
>  				xfiphy4: ethernet-phy@12 {
> -					compatible = "ethernet-phy-ieee802.3-
> c45";
> +					compatible = "ethernet-phy-
> id13e5.1002";
>  					reg = <0x12>;
>  				};
>  			};

I get crashes on boot when using a dtb with this change:

libphy: Fixed MDIO Bus: probed
iommu: Adding device ffe488000.port to group 61
libphy: Freescale XGMAC MDIO Bus: probed
mdio_bus ffe4e1000: Error while reading PHY0 reg at 3.3
iommu: Adding device ffe489000.port to group 63
libphy: Freescale XGMAC MDIO Bus: probed
mdio_bus ffe4e3000: Error while reading PHY0 reg at 3.3
iommu: Adding device ffe48a000.port to group 64
libphy: Freescale XGMAC MDIO Bus: probed
mdio_bus ffe4e5000: Error while reading PHY0 reg at 3.3
iommu: Adding device ffe48b000.port to group 65
libphy: Freescale XGMAC MDIO Bus: probed
mdio_bus ffe4e7000: Error while reading PHY0 reg at 3.3
iommu: Adding device ffe48c000.port to group 66
libphy: Freescale XGMAC MDIO Bus: probed
mdio_bus ffe4e9000: Error while reading PHY0 reg at 3.3
iommu: Adding device ffe48d000.port to group 67
libphy: Freescale XGMAC MDIO Bus: probed
mdio_bus ffe4eb000: Error while reading PHY0 reg at 3.3
iommu: Adding device ffe490000.port to group 68
libphy: Freescale XGMAC MDIO Bus: probed
iommu: Adding device ffe491000.port to group 69
libphy: Freescale XGMAC MDIO Bus: probed
libphy: Freescale XGMAC MDIO Bus: probed
libphy: Freescale XGMAC MDIO Bus: probed
BUG: Kernel NULL pointer dereference at 0x00000000
Faulting instruction address: 0xc000000000842c1c
Oops: Kernel access of bad area, sig: 11 [#1]
BE SMP NR_CPUS=24 CoreNet Generic
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc2+ #25
NIP:  c000000000842c1c LR: c00000000063426c CTR: c0000000006341e8
REGS: c0000002ef1626b0 TRAP: 0300   Not tainted  (4.20.0-rc2+)
MSR:  0000000080029000 <CE,EE,ME>  CR: 24008482  XER: 20000000
DEAR: 0000000000000000 ESR: 0000000000000000 IRQMASK: 0 
GPR00: c00000000054810c c0000002ef162940 c000000000f73a00 c0000002ef1629b4 
GPR04: 0000000000000000 c0000002ed64d128 c0000002ed64d128 0000000000000000 
GPR08: 0000000000000000 0000000000000000 c0000002ef158000 0000000000000001 
GPR12: 0000000084008488 c0000000010f3000 c000000000002464 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000010 
GPR20: c000000000cad9c0 c000000000c8c5e0 fffffffffffff000 c000000000c8c600 
GPR24: c000000000a38db8 0000000000000000 0000000000000000 c0000002ec4ab748 
GPR28: c0000000010e3b70 c000000000e81540 0000000000000000 c0000002ec4ab400 
NIP [c000000000842c1c] .ethtool_convert_link_mode_to_legacy_u32+0x0/0x10
LR [c00000000063426c] .phy_probe+0x84/0x320
Call Trace:
[c0000002ef162940] [c0000002ec4ab410] 0xc0000002ec4ab410 (unreliable)
[c0000002ef1629f0] [c00000000054810c] .really_probe+0x268/0x3d0
[c0000002ef162a90] [c000000000545798] .bus_for_each_drv+0x7c/0xdc
[c0000002ef162b30] [c000000000547e58] .__device_attach+0x108/0x14c
[c0000002ef162bd0] [c000000000546db4] .bus_probe_device+0xcc/0xd8
[c0000002ef162c60] [c000000000543ffc] .device_add+0x4f8/0x6f8
[c0000002ef162d30] [c000000000633894] .phy_device_register+0x68/0xc8
[c0000002ef162db0] [c0000000007be7a0] .of_mdiobus_register_phy+0x150/0x1dc
[c0000002ef162e50] [c0000000007beea8] .of_mdiobus_register+0x14c/0x37c
[c0000002ef162f40] [c000000000646380] .xgmac_mdio_probe+0xf4/0x1cc
[c0000002ef163020] [c00000000054a598] .platform_drv_probe+0x5c/0xa8
[c0000002ef1630a0] [c00000000054810c] .really_probe+0x268/0x3d0
[c0000002ef163140] [c000000000545798] .bus_for_each_drv+0x7c/0xdc
[c0000002ef1631e0] [c000000000547e58] .__device_attach+0x108/0x14c
[c0000002ef163280] [c000000000546db4] .bus_probe_device+0xcc/0xd8
[c0000002ef163310] [c000000000543ffc] .device_add+0x4f8/0x6f8
[c0000002ef1633e0] [c0000000007b8020] .of_device_add+0x68/0x7c
[c0000002ef163450] [c0000000007b86ec]
.of_platform_device_create_pdata+0xc0/0x14
[c0000002ef1634f0] [c0000000007b8964] .of_platform_bus_create+0x174/0x26c
[c0000002ef1635e0] [c0000000007b8bd8] .of_platform_populate+0x58/0xe0
[c0000002ef163680] [c00000000065136c] .fman_probe+0x2b0/0x16a0
[c0000002ef163750] [c00000000054a598] .platform_drv_probe+0x5c/0xa8
[c0000002ef1637d0] [c00000000054810c] .really_probe+0x268/0x3d0
[c0000002ef163870] [c0000000005485f8] .__driver_attach+0x134/0x138
[c0000002ef163900] [c0000000005456a4] .bus_for_each_dev+0x7c/0xe0
[c0000002ef1639a0] [c0000000005478c4] .driver_attach+0x24/0x38
[c0000002ef163a10] [c000000000547178] .bus_add_driver+0x254/0x2d0
[c0000002ef163ab0] [c000000000548fa8] .driver_register+0x8c/0x178
[c0000002ef163b30] [c00000000054a528] .__platform_driver_register+0x48/0x5c
[c0000002ef163ba0] [c000000000d6a940] .fman_load+0x20/0x5c
ata1: No Device OR PHYRDY change,Hstatus = 0xa0000000
[c0000002ef163c20] [c0000000000021b4] .do_one_initcall+0x5c/0x224
ata1: SATA link down (SStatus 10 SControl 300)
ata2: No Device OR PHYRDY change,Hstatus = 0xa0000000
ata2: SATA link down (SStatus 10 SControl 300)
[c0000002ef163cf0] [c000000000d25160] .kernel_init_freeable+0x2d4/0x424
[c0000002ef163da0] [c000000000002480] .kernel_init+0x1c/0x128
[c0000002ef163e20] [c0000000000009f0] .ret_from_kernel_thread+0x58/0x68
Instruction dump:
64631000 78630020 4e800020 e9440030 e9030030 e9230038 7d0a5038 f9430030 
e9440038 7d295038 f9230038 4e800020 <e9240000> 91230000 38600001 4e800020 
---[ end trace fa8c923e42121019 ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
Rebooting in 180 seconds..

-Scott


