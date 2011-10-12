Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F327B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 15:16:50 +1100 (EST)
Subject: Re: [PATCH] powerpc/82xx: updates for mgcoge
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1317109490-4449-1-git-send-email-holger.brunck@keymile.com>
Date: Tue, 11 Oct 2011 23:16:43 -0500
Message-Id: <A01C50B8-30E0-4CC0-96F3-203D5504BC33@kernel.crashing.org>
References: <1317109490-4449-1-git-send-email-holger.brunck@keymile.com>
To: Holger Brunck <holger.brunck@keymile.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 27, 2011, at 2:44 AM, Holger Brunck wrote:

> Add:
> - Setup dts node for USB
> - pin description and setup for SMC1 (serial interface)
> 
> Update and cleanup mgcoge_defconfig:
> - enable: TIPC, UBIFS, USB_GADGET driver, SQUASHFS, HIGHRES timers
>          POSIX_MQUEUE, EMBEDDED
> - disable: EXT3, PPC_PMAC
> 
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> Acked-by: Heiko Schocher <hs@denx.de>
> cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/mgcoge.dts      |    9 +++++++++
> arch/powerpc/configs/mgcoge_defconfig |   27 ++++++++++++++++-----------
> arch/powerpc/platforms/82xx/km82xx.c  |    4 ++++
> 3 files changed, 29 insertions(+), 11 deletions(-)

applied

- k
