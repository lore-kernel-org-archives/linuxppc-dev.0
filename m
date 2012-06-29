Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C9B1FB700F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 05:59:34 +1000 (EST)
Subject: Re: [PATCH v3] powerpc/85xx: Enable MTD/NOR/NAND options by default
 in defconfig
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1335495660-14898-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Fri, 29 Jun 2012 14:59:19 -0500
Message-Id: <47DD81FB-948D-496C-AFDA-42227DC64A3D@kernel.crashing.org>
References: <1335495660-14898-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: dwmw2@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 26, 2012, at 10:01 PM, Shengzhou Liu wrote:

> Enable MTD/NOR/NAND options by default in mpc85xx_defconfig and
> mpc85xx_smp_defconfig to support NOR, NAND flash.
>=20
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> based on master branch of =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git =
tree.
> v3: remove "CONFIG_MTD_NAND_VERIFY_WRITE=3Dy"
> v2: remove typo "CONFIG_MPC8xxx_GPIO=3Dy"
>=20
> arch/powerpc/configs/mpc85xx_defconfig     |   24 =
++++++++++++++++++++++++
> arch/powerpc/configs/mpc85xx_smp_defconfig |   24 =
++++++++++++++++++++++++
> 2 files changed, 48 insertions(+), 0 deletions(-)

[ what about the corenet defconfigs?? ]

applied

- k=
