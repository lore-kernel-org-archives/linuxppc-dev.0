Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A6FE5B6FE2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 07:23:17 +1100 (EST)
Subject: Re: [PATCH 8/9] powerpc/mpc8548cds: rename mpc8548cds.dts to
 mpc8548cds_32b.dts and create mpc8548cds.dtsi
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331024805-15926-7-git-send-email-chenhui.zhao@freescale.com>
Date: Fri, 16 Mar 2012 15:23:13 -0500
Message-Id: <4BBD0F3F-2C9F-4547-B739-0D48A4B0FDE9@kernel.crashing.org>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
 <1331024805-15926-7-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 3:06 AM, Zhao Chenhui wrote:

> * Create mpc8548cds.dtsi.
> * Move lbc, soc and pci0 nodes to mpc8548cds_32b.dtsi.
> * Change cuImage.mpc8548cds to cuImage.mpc8548cds_32b.
> * Rename mpc8548cds.dts to mpc8548cds_32b.dts.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/Makefile               |    2 +-
> arch/powerpc/boot/dts/mpc8548cds.dts     |  357 =
------------------------------
> arch/powerpc/boot/dts/mpc8548cds.dtsi    |  306 =
+++++++++++++++++++++++++
> arch/powerpc/boot/dts/mpc8548cds_32b.dts |   86 +++++++
> 4 files changed, 393 insertions(+), 358 deletions(-)
> delete mode 100644 arch/powerpc/boot/dts/mpc8548cds.dts
> create mode 100644 arch/powerpc/boot/dts/mpc8548cds.dtsi
> create mode 100644 arch/powerpc/boot/dts/mpc8548cds_32b.dts

applied

- k=
