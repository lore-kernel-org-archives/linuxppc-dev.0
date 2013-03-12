Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD44D2C0402
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2013 08:15:17 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r2CLEUvn002116
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Mar 2013 16:15:14 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1278)
Subject: Re: [PATCH 5/8 v2] powerpc/fsl-booke: Add initial silicon device tree
 for
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362686336-5426-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 12 Mar 2013 16:15:15 -0500
Message-Id: <6C5FA540-1DBC-4DA1-8AE8-FC0503752EC9@kernel.crashing.org>
References: <1362686336-5426-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 7, 2013, at 1:58 PM, Kumar Gala wrote:

> Enable a baseline T4240 SoC to boot.  There are several things missing
> from the device trees for T4240:
>=20
> * Proper PAMU topology information
> * DPAA related nodes (Qman, Bman, Fman, Rman, DCE)
> * Prefetch Manager
> * Thermal monitor unit
> * Interlaken
>=20
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Signed-off-by: York Sun <yorksun@freescale.com>
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Added thread ids to cpu nodes
> * removed clock-frequency from PCI nodes as we dont use it
>=20
> arch/powerpc/boot/dts/fsl/qoriq-gpio-1.dtsi |   41 ++++
> arch/powerpc/boot/dts/fsl/qoriq-gpio-2.dtsi |   41 ++++
> arch/powerpc/boot/dts/fsl/qoriq-gpio-3.dtsi |   41 ++++
> arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  307 =
+++++++++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  |  127 +++++++++++
> 5 files changed, 557 insertions(+)
> create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-1.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-2.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-3.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi

applied to next

- k=
