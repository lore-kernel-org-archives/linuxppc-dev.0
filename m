Return-Path: <B11780@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99F7D2C0292
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 03:01:13 +1100 (EST)
Received: from mail121-co1 (localhost [127.0.0.1])	by
 mail121-co1-R.bigfish.com (Postfix) with ESMTP id 0EB857C0237	for
 <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 16:01:10 +0000 (UTC)
Received: from CO1EHSMHS004.bigfish.com (unknown [10.243.78.197])	by
 mail121-co1.bigfish.com (Postfix) with ESMTP id 51124A40129	for
 <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 16:01:07 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Liu Po-B43644 <B43644@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: dts - add ranges property for SEC
Date: Tue, 19 Feb 2013 16:01:03 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D72B420@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1361233746-19106-1-git-send-email-po.liu@freescale.com>
In-Reply-To: <1361233746-19106-1-git-send-email-po.liu@freescale.com>
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


On Feb 18, 2013, at 6:29 PM, Po Liu wrote:

> This facilitates getting the physical address of the SEC node.
>=20
> Signed-off-by: Liu po <po.liu@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

Why are you reposting this, I already applied it:

http://git.kernel.org/?p=3Dlinux/kernel/git/galak/powerpc.git;a=3Dcommit;h=
=3Ddb29cd3c4497e7edf9176284ba7cf3cec1814c7a

- k=
