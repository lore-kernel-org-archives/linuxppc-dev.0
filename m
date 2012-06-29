Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BFA8AB6FBD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 06:02:56 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc: remove Wind River SBC8560 support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1340740469-31445-2-git-send-email-paul.gortmaker@windriver.com>
Date: Fri, 29 Jun 2012 15:02:48 -0500
Message-Id: <84E77150-05F3-45BC-9816-71BA4BBEFDC6@kernel.crashing.org>
References: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
 <1340740469-31445-2-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Woodhouse <David.Woodhouse@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 26, 2012, at 2:54 PM, Paul Gortmaker wrote:

> This reference board dates back to 2004, and is largely a legacy
> EOL product.  The MPC8560 is a pre e500v2 CPU.  The SBC8548 is
> a more modern, better e500v2 target for people to use as a
> reference board with today's kernels, should they require one.
>=20
> Removing support for it will also allow us to remove some
> sbc8560 specific quirk handling in 8250 UART code, and some
> MTD mapping support.
>=20
> Cc: David Woodhouse <David.Woodhouse@intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/Makefile                  |    1 -
> arch/powerpc/boot/dts/sbc8560.dts           |  406 =
---------------------------
> arch/powerpc/configs/85xx/sbc8560_defconfig |   65 -----
> arch/powerpc/platforms/85xx/Kconfig         |    6 -
> arch/powerpc/platforms/85xx/Makefile        |    1 -
> arch/powerpc/platforms/85xx/sbc8560.c       |  254 -----------------
> 6 files changed, 0 insertions(+), 733 deletions(-)
> delete mode 100644 arch/powerpc/boot/dts/sbc8560.dts
> delete mode 100644 arch/powerpc/configs/85xx/sbc8560_defconfig
> delete mode 100644 arch/powerpc/platforms/85xx/sbc8560.c

applied

- k=
