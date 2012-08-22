Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D3BA62C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 01:21:44 +1000 (EST)
Subject: Re: [PATCH] DMA/RaidEngine: Enable FSL RaidEngine
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1345616661-8550-1-git-send-email-b29237@freescale.com>
Date: Wed, 22 Aug 2012 08:37:12 -0500
Message-Id: <D8BA9BE9-CC8A-41EE-B6A6-404682EF78D3@kernel.crashing.org>
References: <1345616661-8550-1-git-send-email-b29237@freescale.com>
To: "<b29237@freescale.com>" <b29237@freescale.com>
Cc: Harninder Rai <harninder.rai@freescale.com>, b01044@freescale.com,
 iws@ovro.caltech.edu, vinod.koul@intel.com, linux-kernel@vger.kernel.org,
 Naveen Burmi <naveenburmi@freescale.com>, dan.j.williams@gmail.com,
 b16502@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 22, 2012, at 1:24 AM, <b29237@freescale.com> =
<b29237@freescale.com> wrote:

> From: Xuelin Shi <b29237@freescale.com>
>=20
> The RaidEngine is a new FSL hardware that used as hardware acceration
> for RAID5/6.
>=20
> This patch enables the RaidEngine functionality and provides hardware
> offloading capability for memcpy, xor and raid6 pq computation. It =
works
> under dmaengine control with async_layer interface.
>=20
> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> Signed-off-by: Naveen Burmi <naveenburmi@freescale.com>
> Signed-off-by: Xuelin Shi <b29237@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/p5020si-post.dtsi    |    1 +
> arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi     |    6 +
> arch/powerpc/boot/dts/fsl/qoriq-raid1.0-0.dtsi |   85 ++
> drivers/dma/Kconfig                            |   14 +
> drivers/dma/Makefile                           |    1 +
> drivers/dma/fsl_raid.c                         | 1090 =
++++++++++++++++++++++++
> drivers/dma/fsl_raid.h                         |  294 +++++++
> 7 files changed, 1491 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-raid1.0-0.dtsi
> create mode 100644 drivers/dma/fsl_raid.c
> create mode 100644 drivers/dma/fsl_raid.h

Where is the dts binding spec related to qoriq-raid1.0-0.dtsi ?

We should split the device tree parts into a separate patch as they can =
be reviewed & accepted separate from the driver code.

- k=
