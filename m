Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8871F2C0200
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 23:22:40 +1000 (EST)
Subject: Re: [PATCH] powerpc: select PPC_CLOCK unconditionally for FSL_SOC
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1333085936-8977-1-git-send-email-shawn.guo@linaro.org>
Date: Tue, 10 Jul 2012 07:24:41 -0500
Message-Id: <881CAA24-930D-4708-9911-80C9B40B0F3C@kernel.crashing.org>
References: <1333085936-8977-1-git-send-email-shawn.guo@linaro.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 30, 2012, at 12:38 AM, Shawn Guo wrote:

> Freescale PowerPC SoCs share a number of IP blocks with Freescale
> ARM/IMX SoCs, FlexCAN, SSI, FEC, eSDHC, USB, etc.  There are some
> effort consolidating those drivers to make them work for both
> architectures.
> 
> One outstanding difference between two architectures is ARM/IMX will
> turn off module clocks during platform initialization for power saving
> and expects drivers manage clocks using clk API, while PowerPC
> mostly does not do that, and thus does not always build in clk API.
> 
> Listing all those driver Kconfig options in "select PPC_CLOCK if" seems
> not scalable for long term maintenance, and could easily introduce
> Kconfig recursive dependency.  This patch chooses to select PPC_CLOCK
> unconditionally for FSL_SOC to always build clk API for PowerPC in.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> arch/powerpc/Kconfig |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k
