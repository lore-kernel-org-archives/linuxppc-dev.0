Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3ACD12C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 03:46:46 +1000 (EST)
Subject: Re: [PATCH V3 3/5] powerpc/mpc85xx: convert to unified PCI init
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343305827-26734-3-git-send-email-B38951@freescale.com>
Date: Thu, 26 Jul 2012 12:46:42 -0500
Message-Id: <802361F1-00A4-4D46-958B-76D80284D9E2@kernel.crashing.org>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <1343305827-26734-3-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 26, 2012, at 7:30 AM, Jia Hongtao wrote:

> PCI initialization is now done by PCI controller driver. In =
board_setup_arch
> stage we don't need PCI init any more but swiotlb should be determined =
at this
> stage.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> We now just apply this for mpc85xx_ds and qemu
>=20
> arch/powerpc/kernel/iommu.c.rej          |   22 -----------------
> arch/powerpc/platforms/85xx/common.c     |    9 +++++++
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |   38 =
+++++++----------------------
> arch/powerpc/platforms/85xx/qemu_e500.c  |    5 +++-
> 4 files changed, 22 insertions(+), 52 deletions(-)
> delete mode 100644 arch/powerpc/kernel/iommu.c.rej

removal of iommu.c.rej is handled by:

commit 668fcb6972177489bdc01a66d697c3b494aa8a24
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon Jul 23 09:38:53 2012 +1000

    Remove stale .rej file

- k=
