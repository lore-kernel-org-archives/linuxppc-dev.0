Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D4C2B1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 09:41:42 +1100 (EST)
Subject: Re: [PATCH v2] DTS: fix cmd12 bug and add the chip compatible for
 eSDHC
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1325727656-18672-1-git-send-email-r66093@freescale.com>
Date: Tue, 17 Jan 2012 16:41:42 -0600
Message-Id: <B889992E-1181-4C1A-8E93-8C7784D91EAA@kernel.crashing.org>
References: <1325727656-18672-1-git-send-email-r66093@freescale.com>
To: "<r66093@freescale.com>" <r66093@freescale.com>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 4, 2012, at 7:40 PM, <r66093@freescale.com> =
<r66093@freescale.com> wrote:

> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>=20
> Accordint to latest kernel, the auto-cmd12 property should be
> "sdhci,auto-cmd12", and according to the SDHC binding and the =
workaround for
> the special chip, add the chip compatible for eSDHC: =
"fsl,p1022-esdhc",
> "fsl,mpc8536-esdhc", "fsl,p2020-esdhc" and "fsl,p1010-esdhc".
>=20
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
> changes for v2:
> 	- reverse the special compatible entries
>=20
> arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    4 ++++
> arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    3 ++-
> arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    3 ++-
> arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |    4 ++++
> 4 files changed, 12 insertions(+), 2 deletions(-)

applied to merge

- k=
