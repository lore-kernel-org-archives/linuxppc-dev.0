Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0934B1007D7
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 18:31:14 +1100 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch (updated)
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <alpine.LFD.2.00.1111232302440.20012@right.am.freescale.net>
Date: Thu, 24 Nov 2011 01:31:08 -0600
Message-Id: <6E4772AD-8272-4A7D-8262-88C385CE9619@kernel.crashing.org>
References: <alpine.LFD.2.00.1111232302440.20012@right.am.freescale.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 23, 2011, at 11:03 PM, Kumar Gala wrote:

> Ben,
>=20
> A few minor fixes for FSL PPC SoCs to send up to Linus.
>=20
> - k
>=20
> The following changes since commit =
caca6a03d365883564885f2c1da3e88dcf65d139:
>=20
>  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)
>=20
> are available in the git repository at:
>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge
>=20
> Kumar Gala (1):
>      powerpc/85xx: Fix compile error on p3060_qds.c
>=20
> Paul Bolle (1):
>      powerpc/p3060qds: Fix select of 'MPC8xxx_GPIO'
>=20
> Roy Zang (1):
>      powerpc/p1023: set IRQ[4:6,11] to active-high level sensitive for =
PCIe
>=20
> arch/powerpc/boot/dts/p1023rds.dts      |   17 +++++++++++++----
> arch/powerpc/platforms/85xx/Kconfig     |    2 +-
> arch/powerpc/platforms/85xx/p3060_qds.c |    2 +-
> 3 files changed, 15 insertions(+), 6 deletions(-)

(updated 'merge' with):

Joakim Tjernlund (1):
      powerpc/qe: Fixup QE_General4 errata

 arch/powerpc/sysdev/qe_lib/qe.c         |    2 +-

- k=
