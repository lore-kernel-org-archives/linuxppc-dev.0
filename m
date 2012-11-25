Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0E1012C014C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 00:21:34 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc/dma/raidengine: add raidengine device
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1353488481-14371-1-git-send-email-b29237@freescale.com>
Date: Sun, 25 Nov 2012 07:21:23 -0600
Message-Id: <879B3D41-9FBD-4BC8-A682-6C4B9244EF12@kernel.crashing.org>
References: <1353488481-14371-1-git-send-email-b29237@freescale.com>
To: "<b29237@freescale.com>" <b29237@freescale.com>
Cc: Harninder Rai <harninder.rai@freescale.com>, iws@ovro.caltech.edu,
 vinod.koul@intel.com, linux-kernel@vger.kernel.org,
 Naveen Burmi <naveenburmi@freescale.com>, dan.j.williams@gmail.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 21, 2012, at 3:01 AM, <b29237@freescale.com> =
<b29237@freescale.com> wrote:

> From: Xuelin Shi <b29237@freescale.com>
>=20
> The RaidEngine is a new Freescale hardware that used for parity
> computation offloading in RAID5/6.
>=20
> This patch adds the device node in device tree and related binding
> documentation.
>=20
> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> Signed-off-by: Naveen Burmi <naveenburmi@freescale.com>
> Signed-off-by: Xuelin Shi <b29237@freescale.com>
> ---
> .../devicetree/bindings/powerpc/fsl/raideng.txt    |   81 =
+++++++++++++++++++
> arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |    1 +
> arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |    6 ++
> arch/powerpc/boot/dts/fsl/qoriq-raid1.0-0.dtsi     |   85 =
++++++++++++++++++++
> 4 files changed, 173 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/raideng.txt
> create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-raid1.0-0.dtsi

applied to next

- k=
