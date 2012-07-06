Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 667392C0203
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2012 00:06:37 +1000 (EST)
Subject: Re: [PATCH] Revert "powerpc/p3060qds: Add support for P3060QDS board"
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341526073-10595-1-git-send-email-timur@freescale.com>
Date: Fri, 6 Jul 2012 09:06:36 -0500
Message-Id: <B652D6B0-4782-4CC5-9685-95A86FACF60A@kernel.crashing.org>
References: <1341526073-10595-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 5, 2012, at 5:07 PM, Timur Tabi wrote:

> This reverts commit 96cc017c5b7ec095ef047d3c1952b6b6bbf98943.
>=20
> The P3060 was cancelled before it went into production, so there's no =
point
> in supporting it.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/p3060si-post.dtsi  |  302 =
--------------------------
> arch/powerpc/boot/dts/fsl/p3060si-pre.dtsi   |  125 -----------
> arch/powerpc/boot/dts/p3060qds.dts           |  242 =
---------------------
> arch/powerpc/configs/corenet32_smp_defconfig |    1 -
> arch/powerpc/platforms/85xx/Kconfig          |   12 -
> arch/powerpc/platforms/85xx/Makefile         |    1 -
> arch/powerpc/platforms/85xx/p3060_qds.c      |   77 -------
> 7 files changed, 0 insertions(+), 760 deletions(-)
> delete mode 100644 arch/powerpc/boot/dts/fsl/p3060si-post.dtsi
> delete mode 100644 arch/powerpc/boot/dts/fsl/p3060si-pre.dtsi
> delete mode 100644 arch/powerpc/boot/dts/p3060qds.dts
> delete mode 100644 arch/powerpc/platforms/85xx/p3060_qds.c

I assume you're sending a similar patch to u-boot.

- k=
