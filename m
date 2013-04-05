Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1D8E12C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 01:22:43 +1100 (EST)
Subject: Re: [PATCH 1/4][v2] powerpc/fsl-booke: Add initial silicon device
 tree files for B4860 and B4420
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1365143632-19362-1-git-send-email-shaveta@freescale.com>
Date: Fri, 5 Apr 2013 09:22:36 -0500
Message-Id: <62911773-1FC6-49B5-993F-88DD0F8F845A@kernel.crashing.org>
References: <1365143632-19362-1-git-send-email-shaveta@freescale.com>
To: Shaveta Leekha <shaveta@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 5, 2013, at 1:33 AM, Shaveta Leekha wrote:

> B4860 and B4420 are similar that share some commonalities
>=20
> * common features have been added in b4si-pre.dtsi and b4si-post.dtsi
> * differences are added in respective silicon files of B4860 and B4420
>=20
> There are several things missing from the device trees of B4860 and =
B4420:
>=20
> * DPAA related nodes (Qman, Bman, Fman, Rman)
> * DSP related nodes/information
> * serdes, sfp(security fuse processor), thermal,
> gpio, maple, cpri, quad timers nodes
>=20
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> ---
> v2:=20
>  - incorporated review comments on commits message
>  - change unit address of cpu nodes to match the reg property
>=20
> arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |   94 ++++++++++
> arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   49 +++++
> arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  138 ++++++++++++++
> arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   59 ++++++
> arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  262 =
+++++++++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/b4si-pre.dtsi     |   65 +++++++
> 6 files changed, 667 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4si-pre.dtsi

Is there a reason you didn't get rid of b4si-pre.dtsi and just merge it =
into b4860si-pre.dtsi & b4420-pre.dtsi?

- k=
