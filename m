Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D48822C045B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 22:24:09 +1000 (EST)
Subject: Re: [PATCH 2/2][v2] powerpc/watchdog: replace CONFIG_FSL_BOOKE with
 CONFIG_PPC_FSL_BOOK3E
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1336714420-2394-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Tue, 10 Jul 2012 07:24:01 -0500
Message-Id: <811A0EE0-6D65-4903-83E6-3F13E35889A3@kernel.crashing.org>
References: <1336714420-2394-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 11, 2012, at 12:33 AM, Shaohui Xie wrote:

> CONFIG_FSL_BOOKE is only defined in 32-bit, CONFIG_PPC_FSL_BOOK3E is
> defined in both 32-bit and 64-bit, so use CONFIG_PPC_FSL_BOOK3E to make
> driver work in 32-bit & 64-bit.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> changes for v2:
> use PPC_FSL_BOOK3E instead of FSL_SOC_BOOKE.
> 
> drivers/watchdog/Kconfig     |    8 ++++----
> drivers/watchdog/booke_wdt.c |    4 ++--
> 2 files changed, 6 insertions(+), 6 deletions(-)

applied to next

- k
