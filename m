Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6E0E1A006A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Aug 2014 05:38:30 +1000 (EST)
Message-ID: <1409341095.24184.18.camel@snotra.buserror.net>
Subject: Re: [PATCHv2] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
From: Scott Wood <scottwood@freescale.com>
To: Jingchang Lu <jingchang.lu@freescale.com>
Date: Fri, 29 Aug 2014 14:38:15 -0500
In-Reply-To: <1409301354-13699-1-git-send-email-jingchang.lu@freescale.com>
References: <1409301354-13699-1-git-send-email-jingchang.lu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mturquette@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-29 at 16:35 +0800, Jingchang Lu wrote:
> The IP is shared on PPC and ARM, this rename it to qoriq for better
> represention, and this also add the CLK_OF_DECLARE support for being
> initialized by of_clk_init() on ARM.
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
> changes in v2:
>  rename the driver name to ppc-qoriq.c for shared on PPC and ARM.
> 
>  drivers/clk/Kconfig           |   9 +-
>  drivers/clk/Makefile          |   2 +-
>  drivers/clk/clk-ppc-corenet.c | 307 -----------------------------------------
>  drivers/clk/clk-qoriq.c       | 312 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 318 insertions(+), 312 deletions(-)
>  delete mode 100644 drivers/clk/clk-ppc-corenet.c
>  create mode 100644 drivers/clk/clk-qoriq.c

Please use -M -C with git format-patch to detect the rename, so we can
see what changed during the rename.

-Scott
