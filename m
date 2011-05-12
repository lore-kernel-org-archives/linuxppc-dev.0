Return-Path: <R58472@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C427DB6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 16:11:15 +1000 (EST)
From: Li Yang-R58472 <R58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, "galak@kernel.crashing.org"
	<galak@kernel.crashing.org>
Subject: RE: [linuxppc-release] [PATCH 1/2] powerpc,	e5500: add networking
	to defconfig
Date: Thu, 12 May 2011 06:11:03 +0000
Message-ID: <3F607A5180246847A760FD34122A1E0514EC65@039-SN1MPN1-002.039d.mgd.msft.net>
References: <20110510180147.GA18443@schlenkerla.am.freescale.net>
In-Reply-To: <20110510180147.GA18443@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: [linuxppc-release] [PATCH 1/2] powerpc, e5500: add networking to
>defconfig
>
>Even though support for the p5020's on-chip ethernet is not yet upstream,
>it is not appropriate to disable all networking support (including
>loopback, unix domain sockets, external ethernet devices, etc) in the
>defconfig.  The networking settings are taken from mpc85xx_smp_defconfig,
>minus the drivers for ethernet devices not found on any current e5500 chip=
.
>
>The other changes are the result of running "make savedefconfig".
>
>Signed-off-by: Scott Wood <scottwood@freescale.com>
>---
> arch/powerpc/configs/e55xx_smp_defconfig |   38 ++++++++++++++++++++++---
>----
> 1 files changed, 29 insertions(+), 9 deletions(-)
>
>diff --git a/arch/powerpc/configs/e55xx_smp_defconfig
>b/arch/powerpc/configs/e55xx_smp_defconfig
>index 9fa1613..f4c5780 100644
>--- a/arch/powerpc/configs/e55xx_smp_defconfig
>+++ b/arch/powerpc/configs/e55xx_smp_defconfig
>@@ -6,10 +6,10 @@ CONFIG_NR_CPUS=3D2
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
>+CONFIG_SPARSE_IRQ=3Dy

Hi Scott,

I remember in previous testing that this option has a negative effect on pe=
rformance.  Do we really need it to be enabled?

- Leo
