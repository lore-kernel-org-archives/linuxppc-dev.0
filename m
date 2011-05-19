Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 919A5B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 16:01:29 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc,e5500: add networking to defconfig
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110510180147.GA18443@schlenkerla.am.freescale.net>
Date: Thu, 19 May 2011 01:01:19 -0500
Message-Id: <366EDEF5-7E8A-4F24-95B8-3665EA1A5E32@kernel.crashing.org>
References: <20110510180147.GA18443@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 10, 2011, at 1:01 PM, Scott Wood wrote:

> Even though support for the p5020's on-chip ethernet is not yet =
upstream,
> it is not appropriate to disable all networking support (including
> loopback, unix domain sockets, external ethernet devices, etc) in the
> defconfig.  The networking settings are taken from =
mpc85xx_smp_defconfig,
> minus the drivers for ethernet devices not found on any current e5500
> chip.
>=20
> The other changes are the result of running "make savedefconfig".
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/configs/e55xx_smp_defconfig |   38 =
++++++++++++++++++++++-------
> 1 files changed, 29 insertions(+), 9 deletions(-)

applied to next

- k=
