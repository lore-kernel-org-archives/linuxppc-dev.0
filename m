Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E917F2C00BC
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Nov 2013 03:28:02 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH V2] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
Date: Tue, 12 Nov 2013 10:27:56 -0600
Message-Id: <B1190D51-6D79-43C6-8021-2E2F1ED59722@kernel.crashing.org>
References: <1383952632-5770-1-git-send-email-Lijun.Pan@freescale.com>
 <1384197913-24610-1-git-send-email-Lijun.Pan@freescale.com>
To: Lijun Pan <Lijun.Pan@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 11, 2013, at 1:25 PM, Lijun Pan <Lijun.Pan@freescale.com> wrote:

> mpc85xx_smp_defconfig and mpc85xx_defconfig already have =
CONFIG_P1023RDS=3Dy.
> Merge CONFIG_P1023RDB=3Dy and other relevant configurations into =
mpc85xx_smp_defconfig and mpc85_defconfig.
>=20
> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
> ---
> arch/powerpc/configs/85xx/p1023_defconfig  |  188 =
----------------------------
> arch/powerpc/configs/mpc85xx_defconfig     |   18 +++
> arch/powerpc/configs/mpc85xx_smp_defconfig |   17 +++
> 3 files changed, 35 insertions(+), 188 deletions(-)
> delete mode 100644 arch/powerpc/configs/85xx/p1023_defconfig

How much of the changes to mpc85xx_defconfig & mpc85xx_smp_defconfig are =
based on just updating them vs changes for p1023?

Can we do this as two patches.  One that updates mpc85xx_defconfig & =
mpc85xx_smp_defconfig and one that makes the p1023 changes.  That is =
much easier to review as well.

- k=
