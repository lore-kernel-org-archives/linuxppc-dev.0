Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 327BD1007D1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:25:45 +1000 (EST)
Subject: Re: powerpc, 8xx: Add support for the MPC8xx based boards from TQC
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4BA8744D.6030503@denx.de>
Date: Wed, 4 Aug 2010 14:25:35 -0500
Message-Id: <AC0824BA-58CC-401A-8EE5-0678FE4D327B@kernel.crashing.org>
References: <4BA8744D.6030503@denx.de>
To: hs@denx.de
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 23, 2010, at 2:57 AM, Heiko Schocher wrote:

> Supported SMC1 (serial console), SCC1 Ethernet (10Mbps HD).
> FEC Ethernet, 8MB NOR CFI Flash.
>=20
> Tested on STK8xx with TQM860L (with FEC)
> and with TQM855M (without FEC).
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> - based against =
git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>  commit bca14dd14f3b0c5e3e2d1d314679f85b67871365
> - checked with checkpatch
>  $ scripts/checkpatch.pl =
0001-powerpc-8xx-Add-support-for-the-MPC8xx-based-board.patch
>  total: 0 errors, 0 warnings, 1278 lines checked
>=20
>  0001-powerpc-8xx-Add-support-for-the-MPC8xx-based-board.patch has no =
obvious style problems and is ready for submission.
>  $
>=20
> arch/powerpc/boot/dts/tqm8xx.dts          |  172 ++++++
> arch/powerpc/configs/tqm8xx_defconfig     |  934 =
+++++++++++++++++++++++++++++
> arch/powerpc/platforms/8xx/Kconfig        |    6 +
> arch/powerpc/platforms/8xx/Makefile       |    1 +
> arch/powerpc/platforms/8xx/tqm8xx_setup.c |  156 +++++
> 5 files changed, 1269 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/tqm8xx.dts
> create mode 100644 arch/powerpc/configs/tqm8xx_defconfig
> create mode 100644 arch/powerpc/platforms/8xx/tqm8xx_setup.c

applied to next

- k=
