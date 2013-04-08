Return-Path: <B20052@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62CB02C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 14:48:18 +1000 (EST)
From: Leekha Shaveta-B20052 <B20052@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/4][v2] powerpc/fsl-booke: Add initial silicon device
 tree files for B4860 and B4420
Date: Mon, 8 Apr 2013 04:48:10 +0000
Message-ID: <E12D2F89F87F4A49B0320A4C2DE7E749152991@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1365143632-19362-1-git-send-email-shaveta@freescale.com>
 <62911773-1FC6-49B5-993F-88DD0F8F845A@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Leekha Shaveta-B20052=20
Sent: Friday, April 05, 2013 9:13 PM
To: 'Kumar Gala'
Cc: linuxppc-dev@lists.ozlabs.org list
Subject: RE: [PATCH 1/4][v2] powerpc/fsl-booke: Add initial silicon device =
tree files for B4860 and B4420



-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Friday, April 05, 2013 7:53 PM
To: Leekha Shaveta-B20052
Cc: linuxppc-dev@lists.ozlabs.org list
Subject: Re: [PATCH 1/4][v2] powerpc/fsl-booke: Add initial silicon device =
tree files for B4860 and B4420


On Apr 5, 2013, at 1:33 AM, Shaveta Leekha wrote:

> B4860 and B4420 are similar that share some commonalities
>=20
> * common features have been added in b4si-pre.dtsi and b4si-post.dtsi
> * differences are added in respective silicon files of B4860 and B4420
>=20
> There are several things missing from the device trees of B4860 and B4420=
:
>=20
> * DPAA related nodes (Qman, Bman, Fman, Rman)
> * DSP related nodes/information
> * serdes, sfp(security fuse processor), thermal, gpio, maple, cpri,=20
> quad timers nodes
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
> arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  262 ++++++++++++++++++++++=
+++++
> arch/powerpc/boot/dts/fsl/b4si-pre.dtsi     |   65 +++++++
> 6 files changed, 667 insertions(+), 0 deletions(-) create mode 100644=20
> arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4si-pre.dtsi

Is there a reason you didn't get rid of b4si-pre.dtsi and just merge it int=
o b4860si-pre.dtsi & b4420-pre.dtsi?
[SL] No particular reason. I have just tried to re-factored these files as =
you have suggested. Hence managed the commonalities in B4 files and differe=
nces in B4860's and B4420's respective files to reduce duplicity.

Regards,
Shaveta=20

[SL] Kumar, please suggest.=20

Regards,
Shaveta
