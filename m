Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D05E41A0A01
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 22:11:00 +1000 (AEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NMS00BZVPDHPAB0@mailout1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 14 Apr 2015 21:00:53 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 2/3] Remove celleb-only SCC PATA drivers
Date: Tue, 14 Apr 2015 13:58:14 +0200
Message-id: <7604591.MsqiRRA37E@amdc1032>
In-reply-to: <1428989326-7637-2-git-send-email-dja@axtens.net>
References: <1428989326-7637-1-git-send-email-dja@axtens.net>
 <1428989326-7637-2-git-send-email-dja@axtens.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

On Tuesday, April 14, 2015 03:28:45 PM Daniel Axtens wrote:
> The SCC PATA interface is only used by celleb.
> celleb has been dropped [1], so drop the drivers.
> 
> [1] http://patchwork.ozlabs.org/patch/451730/
> 
> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> CC: Tejun Heo <tj@kernel.org>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: linux-ide@vger.kernel.org
> CC: Valentin Rothberg <valentinrothberg@gmail.com>
> CC: mpe@ellerman.id.au
> CC: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> v2: get name of ozlab*s*.org right. Sorry all.
> ---
>  drivers/ata/Kconfig    |    9 -
>  drivers/ata/Makefile   |    1 -
>  drivers/ata/pata_scc.c | 1110 ------------------------------------------------
>  drivers/ide/Kconfig    |    9 -
>  drivers/ide/Makefile   |    1 -
>  drivers/ide/scc_pata.c |  887 --------------------------------------
>  6 files changed, 2017 deletions(-)
>  delete mode 100644 drivers/ata/pata_scc.c
>  delete mode 100644 drivers/ide/scc_pata.c

For PATA part:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

If Tejun & Dave are OK with it this patch can go through libata tree.
Otherwise you will need to split it on separate libata/IDE patches.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
