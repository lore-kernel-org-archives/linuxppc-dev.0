Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 955F0B6FF4
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 07:01:16 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: allow CONFIG_PHYS_64BIT to be selectable
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1329853995-7533-1-git-send-email-timur@freescale.com>
Date: Fri, 16 Mar 2012 15:01:10 -0500
Message-Id: <F8EF37FA-4F99-4B4E-9D87-B7BA7DF349CD@kernel.crashing.org>
References: <1329853995-7533-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 21, 2012, at 1:53 PM, Timur Tabi wrote:

> Remove the "select PHYS_64BIT" from the Kconfig entry for the P1022DS,
> so that large physical address support is a selectable option for =
non-CoreNet
> reference boards.
>=20
> The option is enabled in mpc85xx_[smp_]defconfig so that the default =
is
> unchanged.  However, now it can be deselected.
>=20
> The P1022DS had this option defined because the default device tree =
for
> this board uses 36-bit addresses.  This had the side-effect of forcing
> this option on for all boards that use mpc85xx_[smp_]defconfig.  Some
> users may want to disable this feature to create an optimized =
configuration
> for boards with <=3D 2GB of RAM.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/configs/mpc85xx_defconfig     |    1 +
> arch/powerpc/configs/mpc85xx_smp_defconfig |    1 +
> arch/powerpc/platforms/85xx/Kconfig        |    1 -
> 3 files changed, 2 insertions(+), 1 deletions(-)

applied

- k=
