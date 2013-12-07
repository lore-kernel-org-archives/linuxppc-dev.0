Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C84F02C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:55:11 +1100 (EST)
Date: Sat, 7 Dec 2013 10:55:07 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 12/17] mtd: mpc5121_nfc: adjust for OF based clock
 lookup
Message-ID: <20131207105507.7bbf4283@crub>
In-Reply-To: <1385851897-23475-13-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-13-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:32 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> after device tree based clock lookup became available, the NAND
> flash driver need no longer use the previous global "nfc_clk" name,
> but should use the "ipg" clock name specific to the OF node
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/mtd/nand/mpc5121_nfc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to next. Thanks!

Anatolij
