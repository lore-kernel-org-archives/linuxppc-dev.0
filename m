Return-Path: <B11780@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 51D182C032E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 04:18:55 +1100 (EST)
Received: from mail199-va3 (localhost [127.0.0.1])	by
 mail199-va3-R.bigfish.com (Postfix) with ESMTP id B431D46011A	for
 <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 17:18:51 +0000 (UTC)
Received: from VA3EHSMHS018.bigfish.com (unknown [10.7.14.241])	by
 mail199-va3.bigfish.com (Postfix) with ESMTP id 6B25C1801F5	for
 <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 17:18:49 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Rai Harninder-B01044 <B01044@freescale.com>
Subject: Re: [PATCH] bsc9131/dts: Correct typo in SDHC device node
Date: Tue, 19 Feb 2013 17:18:44 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D72B685@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1361265238-28100-1-git-send-email-harninder.rai@freescale.com>
In-Reply-To: <1361265238-28100-1-git-send-email-harninder.rai@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 19, 2013, at 3:13 AM, Harninder Rai wrote:

> BSC9131RDB doesn't have SDHC enabled. As a result of this typo,
> the node was not getting disabled from the device tree which was
> leading to linux hang during bootup
>=20
> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> ---
> arch/powerpc/boot/dts/bsc9131rdb.dtsi |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k
