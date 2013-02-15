Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD8842C02BF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2013 07:05:24 +1100 (EST)
Subject: Re: [PATCH v3 1/1] powerpc/85xx: Board support for ppa8548
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1360764540-4185-1-git-send-email-stef.van.os@prodrive.nl>
Date: Fri, 15 Feb 2013 14:03:10 -0600
Message-Id: <19684E02-1C40-4296-850E-4FC9D5C55DD4@kernel.crashing.org>
References: <1360764540-4185-1-git-send-email-stef.van.os@prodrive.nl>
To: Stef van Os <stef.van.os@Prodrive.nl>
Cc: scottwood@freescale.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, timur.tabi@calxeda.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 13, 2013, at 8:09 AM, Stef van Os wrote:

> Initial board support for the Prodrive PPA8548 AMC module. Board
> is an MPC8548 AMC platform used in RapidIO systems. This module is
> also used to test/work on mainline linux RapidIO software.
>=20
> PPA8548 overview:
> - 1.3 GHz Freescale PowerQUICC III MPC8548 processor
> - 1 GB DDR2 @ 266 MHz
> - 8 MB NOR flash
> - Serial RapidIO 1.2
> - 1 x 10/100/1000 BASE-T front ethernet
> - 1 x 1000 BASE-BX ethernet on AMC connector
>=20
> Signed-off-by: Stef van Os <stef.van.os@prodrive.nl>
> ---
> arch/powerpc/boot/dts/ppa8548.dts           |  166 =
+++++++++++++++++++++++++++
> arch/powerpc/configs/85xx/ppa8548_defconfig |   65 +++++++++++
> arch/powerpc/platforms/85xx/Kconfig         |    7 +
> arch/powerpc/platforms/85xx/Makefile        |    1 +
> arch/powerpc/platforms/85xx/ppa8548.c       |   98 ++++++++++++++++
> 5 files changed, 337 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/ppa8548.dts
> create mode 100644 arch/powerpc/configs/85xx/ppa8548_defconfig
> create mode 100644 arch/powerpc/platforms/85xx/ppa8548.c

applied to next

- k=
