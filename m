Return-Path: <B11780@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1E6D2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 00:01:27 +1100 (EST)
Received: from mail81-am1 (localhost [127.0.0.1])	by mail81-am1-R.bigfish.com
 (Postfix) with ESMTP id 373D832030E	for
 <linuxppc-dev@lists.ozlabs.org>; Sun,
 25 Nov 2012 13:01:22 +0000 (UTC)
Received: from AM1EHSMHS013.bigfish.com (unknown [10.3.201.246])	by
 mail81-am1.bigfish.com (Postfix) with ESMTP id C0707A0058	for
 <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2012 13:01:19 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: sun york-R58495 <R58495@freescale.com>
Subject: Re: [PATCH] powerpc/mpc85xx: Change spin table to cached memory
Date: Sun, 25 Nov 2012 13:01:17 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D671DC2@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1348962275-24052-1-git-send-email-yorksun@freescale.com>
In-Reply-To: <1348962275-24052-1-git-send-email-yorksun@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 29, 2012, at 6:44 PM, York Sun wrote:

> ePAPR v1.1 requires the spin table to be in cached memory. So we need
> to change the call argument of ioremap to enable cache and coherence.
> We also flush the cache after writing to spin table to keep it compatible
> with previous cache-inhibit spin table. Flushing before and after
> accessing spin table is recommended by ePAPR.
>=20
> Signed-off-by: York Sun <yorksun@freescale.com>
> Acked-by: Timur Tabi <timur@freescale.com>
> ---
> This patch applies to git://git.kernel.org/pub/scm/linux/kernel/git/galak=
/powerpc.git next branch.
>=20
> arch/powerpc/platforms/85xx/smp.c |   49 +++++++++++++++++++++++++++-----=
-----
> 1 file changed, 36 insertions(+), 13 deletions(-)

applied to next

- k=
