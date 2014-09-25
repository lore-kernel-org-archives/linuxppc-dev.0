Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0104.outbound.protection.outlook.com [65.55.169.104])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A92431A006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 06:42:11 +1000 (EST)
Message-ID: <1411677716.13320.206.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/3] qe_common: add qe common functions to qe_common.c
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Thu, 25 Sep 2014 15:41:56 -0500
In-Reply-To: <1411613237-2271-1-git-send-email-B45475@freescale.com>
References: <1411613237-2271-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-25 at 10:47 +0800, Zhao Qiang wrote:
> qe need to call some common functions, move them into
> public directory, add a new file drivers/soc/qe/qe_common.c
> for them.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  drivers/soc/qe/Makefile    |   2 +-
>  drivers/soc/qe/qe_common.c | 185 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fsl/qe.h     |  52 +++++++++++--
>  3 files changed, 230 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/soc/qe/qe_common.c

I see code being copied, not moved.

Where is patch 1/3?

-Scott
