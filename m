Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B855B7011
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 02:12:09 +1100 (EST)
Subject: Re: [PATCH] ppc, 8xx: remove obsolete mgsuvd board
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4D2EEBEF.2010005@keymile.com>
Date: Tue, 15 Mar 2011 10:11:57 -0500
Message-Id: <16283DF9-5AFE-4553-B0CF-DE25DE3D1E66@kernel.crashing.org>
References: <4D2EEBEF.2010005@keymile.com>
To: Holger Brunck <holger.brunck@keymile.com>
Cc: Heiko Schocher <hs@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 13, 2011, at 6:11 AM, Holger Brunck wrote:

> The MPC852 based mgsuvd board from Keymile was initially ported,
> but later on not developed further. This patch removes the respective
> files to decrease merging conflicts and unneeded maintenance.
>=20
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> Acked-by: Heiko Schocher<hs@denx.de>
> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Marcelo Tosatti <marcelo@kvack.org>
> ---
> arch/powerpc/boot/dts/mgsuvd.dts      |  163 =
---------------------------------
> arch/powerpc/configs/mgsuvd_defconfig |   81 ----------------
> arch/powerpc/platforms/8xx/Kconfig    |    6 -
> arch/powerpc/platforms/8xx/Makefile   |    1 -
> arch/powerpc/platforms/8xx/mgsuvd.c   |   92 ------------------
> 5 files changed, 0 insertions(+), 343 deletions(-)
> delete mode 100644 arch/powerpc/boot/dts/mgsuvd.dts
> delete mode 100644 arch/powerpc/configs/mgsuvd_defconfig
> delete mode 100644 arch/powerpc/platforms/8xx/mgsuvd.c

applied

- k=
