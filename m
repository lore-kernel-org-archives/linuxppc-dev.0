Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EC320B6F76
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2011 15:21:12 +1100 (EST)
Subject: Re: [PATCH 2/4] powerpc/85xx: Rename p2040_rdb.c to p2041_rdb.c
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1314905178-4394-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 11 Oct 2011 23:20:59 -0500
Message-Id: <69DF0522-BD50-49AE-BAD2-7814DF3693BD@kernel.crashing.org>
References: <1314905178-4394-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 1, 2011, at 2:26 PM, Kumar Gala wrote:

> From: Mingkai Hu <Mingkai.hu@freescale.com>
>=20
> There's only p2041rdb board for official release, but the p2041 =
silicon
> on the board can be converted to p2040 silicon without XAUI and L2 =
cache
> function, then the board becomes p2040rdb board. so we use the file =
name
> p2041_rdb.c to handle P2040RDB board and P2041RDB board which is also
> consistent with the board name under U-Boot.
>=20
> During the rename we make few other minor changes to the device tree:
> * Move USB phy setting into p2041si.dtsi as its SoC not board defined
> * Convert PCI clock-frequency to decimal to be more readable
>=20
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/p2040rdb.dts           |  166 -------
> arch/powerpc/boot/dts/p2040si.dtsi           |  623 =
--------------------------
> arch/powerpc/boot/dts/p2041rdb.dts           |  161 +++++++
> arch/powerpc/boot/dts/p2041si.dtsi           |  623 =
++++++++++++++++++++++++++
> arch/powerpc/configs/corenet32_smp_defconfig |    2 +-
> arch/powerpc/platforms/85xx/Kconfig          |    6 +-
> arch/powerpc/platforms/85xx/Makefile         |    2 +-
> arch/powerpc/platforms/85xx/p2040_rdb.c      |   88 ----
> arch/powerpc/platforms/85xx/p2041_rdb.c      |   88 ++++
> 9 files changed, 877 insertions(+), 882 deletions(-)
> delete mode 100644 arch/powerpc/boot/dts/p2040rdb.dts
> delete mode 100644 arch/powerpc/boot/dts/p2040si.dtsi
> create mode 100644 arch/powerpc/boot/dts/p2041rdb.dts
> create mode 100644 arch/powerpc/boot/dts/p2041si.dtsi
> delete mode 100644 arch/powerpc/platforms/85xx/p2040_rdb.c
> create mode 100644 arch/powerpc/platforms/85xx/p2041_rdb.c

applied

- k
