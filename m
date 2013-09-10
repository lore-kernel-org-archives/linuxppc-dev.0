Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 600B32C0103
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 08:25:51 +1000 (EST)
Message-ID: <1378851925.12204.362.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/7] powerpc/mpc85xx: Fix EDAC address capture
From: Scott Wood <scottwood@freescale.com>
To: York Sun <yorksun@freescale.com>
Date: Tue, 10 Sep 2013 17:25:25 -0500
In-Reply-To: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
References: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-06 at 08:43 -0700, York Sun wrote:
> Extend err_addr to cover 64 bits for DDR errors.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> ---
>  drivers/edac/mpc85xx_edac.c |   10 +++++++---
>  drivers/edac/mpc85xx_edac.h |    1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)

EDAC patches should go via the linux-edac list and maintainer.

BTW, were those "reviewed-by" and "tested-by" added by Andy manually, or
are they from gerrit?  If the latter, please strip them before sending
upstream.

-Scott
