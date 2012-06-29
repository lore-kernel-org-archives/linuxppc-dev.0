Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B2DD1007DC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 06:03:28 +1000 (EST)
Subject: Re: [PATCH 3/4] powerpc/83xx: update defconfig for kmeter1
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1336485442-24190-3-git-send-email-holger.brunck@keymile.com>
Date: Fri, 29 Jun 2012 15:03:21 -0500
Message-Id: <748A03E4-A2C2-492B-B3D2-F513CB82E26A@kernel.crashing.org>
References: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
 <1336485442-24190-3-git-send-email-holger.brunck@keymile.com>
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

> Switch on UBIFS, HOTPLUG and TIPC and update the config to
> the latest kernel version.
> 
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> cc: Heiko Schocher <hs@denx.de>
> cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/configs/83xx/kmeter1_defconfig |   22 ++++++++--------------
> 1 files changed, 8 insertions(+), 14 deletions(-)

applied

- k
