Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 081E52C0333
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 07:35:15 +1000 (EST)
Received: from mail33-ch1 (localhost [127.0.0.1])	by mail33-ch1-R.bigfish.com
 (Postfix) with ESMTP id 2917D2201AA	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 27 Sep 2013 21:35:10 +0000 (UTC)
Received: from CH1EHSMHS019.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.243])	by mail33-ch1.bigfish.com (Postfix) with ESMTP id
 AC84432005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 21:35:07 +0000 (UTC)
Message-ID: <1380317704.24959.491.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/p1010rdb:update dts to adapt to both old and
 new p1010rdb
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Fri, 27 Sep 2013 16:35:04 -0500
In-Reply-To: <1379816919-13851-1-git-send-email-B45475@freescale.com>
References: <1379816919-13851-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-09-22 at 10:28 +0800, Zhao Qiang wrote:
> P1010rdb-pa and p1010rdb-pb have different phy interrupts.
> So update dts to adapt to both p1010rdb-pa and p1010rdb-pb.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  arch/powerpc/boot/dts/p1010rdb-pa.dts | 33 ++++++++++++++++++
>  arch/powerpc/boot/dts/p1010rdb-pb.dts | 33 ++++++++++++++++++
>  arch/powerpc/boot/dts/p1010rdb.dts    | 66 -----------------------------------
>  arch/powerpc/boot/dts/p1010rdb.dtsi   | 51 ++++++++++++++++++++++++---
>  4 files changed, 112 insertions(+), 71 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa.dts
>  create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dts
>  delete mode 100644 arch/powerpc/boot/dts/p1010rdb.dts

What about p1010rdb_36b.dts?

-Scott
