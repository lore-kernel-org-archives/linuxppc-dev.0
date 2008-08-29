Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7D68DE037
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 22:05:19 +1000 (EST)
Message-Id: <19CD9ACD-8960-4BA1-BD00-0C1121C79F18@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <485415AC.9090001@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] [8xx] powerpc: Add support for the MPC852 based mgsuvd
	board from keymile.
Date: Fri, 29 Aug 2008 07:04:56 -0500
References: <20080612152838.GA2756@loki.buserror.net>	<4852A09B.100@denx.de>	<4852977B.8030800@freescale.com>	<4852D0D0.4030701@denx.de>
	<20080614175733.a2036f44.sfr@canb.auug.org.au>
	<485415AC.9090001@denx.de>
Cc: Scott Wood <scottwood@freescale.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 14, 2008, at 2:02 PM, Heiko Schocher wrote:

> here the updated patch for the mgsuvd board.
>
> [powerpc]  add support for the MPC852 based mgsuvd board from
>           keymile to arch/powerpc. Supported SMC1 (serial console),
>           SCC3 Ethernet (10Mbps hdx).
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> arch/powerpc/boot/dts/mgsuvd.dts      |  163 ++++++
> arch/powerpc/configs/mgsuvd_defconfig |  872 ++++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/8xx/Kconfig    |    6 +
> arch/powerpc/platforms/8xx/Makefile   |    1 +
> arch/powerpc/platforms/8xx/mgsuvd.c   |   92 ++++
> 5 files changed, 1134 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mgsuvd.dts
> create mode 100644 arch/powerpc/configs/mgsuvd_defconfig
> create mode 100644 arch/powerpc/platforms/8xx/mgsuvd.c



applied to powerpc-next.

- k
