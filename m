Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 17477B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 06:03:35 +1000 (EST)
Subject: Re: [PATCH 4/4] powerpc/82xx: add SPI support for mgcoge
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1336485442-24190-4-git-send-email-holger.brunck@keymile.com>
Date: Fri, 29 Jun 2012 15:03:29 -0500
Message-Id: <441C9483-742F-46AE-BB51-A91E6C3A9233@kernel.crashing.org>
References: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
 <1336485442-24190-4-git-send-email-holger.brunck@keymile.com>
To: Holger Brunck <holger.brunck@keymile.com>
Cc: Heiko Schocher <hs@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 8, 2012, at 8:57 AM, Holger Brunck wrote:

> Add spi support for mgcoge into the platform code and the dts
> file. Additionaly SPIDEV is switched on in the defconfig and the
> updates for the newer kernel version are committed. The SPI
> interface is used to drive the Maxim DS3106 clock chip.
> 
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> cc: Heiko Schocher <hs@denx.de>
> cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/mgcoge.dts      |   23 +++++++++++++++++++++++
> arch/powerpc/configs/mgcoge_defconfig |   12 ++++--------
> arch/powerpc/platforms/82xx/km82xx.c  |    5 +++++
> 3 files changed, 32 insertions(+), 8 deletions(-)

applied

- k
