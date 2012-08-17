Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 565062C008B
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2012 15:32:10 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch (updated)
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <alpine.LFD.2.00.1208100806200.16855@right.am.freescale.net>
Date: Fri, 17 Aug 2012 00:28:48 -0500
Message-Id: <2F2AC95E-BCAD-4EE6-BC63-E8EF5B3584BE@kernel.crashing.org>
References: <alpine.LFD.2.00.1208030838490.4148@right.am.freescale.net>
 <1344033253.24037.70.camel@pasglop>
 <7009C85C-A90F-4477-821A-507259A8F595@kernel.crashing.org>
 <alpine.LFD.2.00.1208100806200.16855@right.am.freescale.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Poke.  :)

- k

On Aug 10, 2012, at 8:07 AM, Kumar Gala wrote:

> Ben,
>=20
> Two updates from last week (one dts bug fix, one minor defconfig =
update)
>=20
> - k
>=20
> The following changes since commit =
0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
>=20
>  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
>=20
> are available in the git repository at:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge
>=20
> for you to fetch changes up to =
09a3017a585eb8567a7de15b426bb1dfb548bf0f:
>=20
>  powerpc/p4080ds: dts - add usb controller version info and port0 =
(2012-08-10 07:47:02 -0500)
>=20
> ----------------------------------------------------------------
> Jia Hongtao (1):
>      powerpc/fsl-pci: Only scan PCI bus if configured as a host
>=20
> Shengzhou Liu (1):
>      powerpc/p4080ds: dts - add usb controller version info and port0
>=20
> Zhao Chenhui (1):
>      powerpc/85xx: mpc85xx_defconfig - add VIA PATA support for =
MPC85xxCDS
>=20
> arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    7 +++++++
> arch/powerpc/configs/mpc85xx_defconfig      |    1 +
> arch/powerpc/sysdev/fsl_pci.c               |   13 ++++++++-----
> 3 files changed, 16 insertions(+), 5 deletions(-)
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
