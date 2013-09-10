Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79C182C04A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 08:26:24 +1000 (EST)
Message-ID: <1378851975.12204.363.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/7] i2c/rtc-ds3232: Fix irq for probing
From: Scott Wood <scottwood@freescale.com>
To: York Sun <yorksun@freescale.com>
Date: Tue, 10 Sep 2013 17:26:15 -0500
In-Reply-To: <1378482199-10581-3-git-send-email-yorksun@freescale.com>
References: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
 <1378482199-10581-3-git-send-email-yorksun@freescale.com>
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
> Driver shouldn't request irq when irq = 0. It is returned from parsing
> device tree. 0 means no interrupt.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> Reviewed-by: Zang Tiefei-R61911 <tie-fei.zang@freescale.com>
> Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
> ---
>  drivers/rtc/rtc-ds3232.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This should go via the i2c list and maintainer.  It's not a PPC patch at
all.

Please do not lump unrelated patches into a single patchset.

-Scott
