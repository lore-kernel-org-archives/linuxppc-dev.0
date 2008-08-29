Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8192DE108
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 22:05:07 +1000 (EST)
Message-Id: <B7142E81-8992-4F05-BCAA-A4AAA41C0689@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <4858C988.1000405@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] [82xx] powerpc: Add support for mpc8247 based
	board	MGCOGE from keymile.
Date: Fri, 29 Aug 2008 07:04:54 -0500
References: <20080612153215.GB2756@loki.buserror.net>
	<4852A144.6090204@denx.de> <20080616072625.GB28470@yookeroo.seuss>
	<4856350E.4080602@denx.de>
	<20080616164915.GA14020@loki.buserror.net>
	<4858C988.1000405@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2008, at 3:38 AM, Heiko Schocher wrote:

> Hello,
>
> changes since the last patch:
>
> update the Portpin initialization.
>
> [powerpc]  Added support for the MPC8247 based board MGCOGE
>           from Keymile.
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> arch/powerpc/boot/dts/mgcoge.dts      |  174 +++++++
> arch/powerpc/configs/mgcoge_defconfig |  900 ++++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/82xx/Kconfig   |    8 +
> arch/powerpc/platforms/82xx/Makefile  |    1 +
> arch/powerpc/platforms/82xx/mgcoge.c  |  129 +++++
> 5 files changed, 1212 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mgcoge.dts
> create mode 100644 arch/powerpc/configs/mgcoge_defconfig
> create mode 100644 arch/powerpc/platforms/82xx/mgcoge.c


applied to powerpc-next.

- k
