Return-Path: <B43644@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9EA362C0085
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 12:37:28 +1100 (EST)
Received: from mail193-tx2 (localhost [127.0.0.1])	by
 mail193-tx2-R.bigfish.com (Postfix) with ESMTP id D8E784602D3	for
 <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 01:37:25 +0000 (UTC)
Received: from TX2EHSMHS021.bigfish.com (unknown [10.9.14.247])	by
 mail193-tx2.bigfish.com (Postfix) with ESMTP id 107EA160054	for
 <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2013 01:37:24 +0000 (UTC)
From: Liu Po-B43644 <B43644@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: dts - add ranges property for SEC
Date: Wed, 20 Feb 2013 01:37:22 +0000
Message-ID: <D473A0D087F4EA47A30C37E4637E25E61923C3@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1361233746-19106-1-git-send-email-po.liu@freescale.com>
 <CF1EE7AED478CD48A05574C8E2DA142D72B420@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <CF1EE7AED478CD48A05574C8E2DA142D72B420@039-SN1MPN1-005.039d.mgd.msft.net>
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

Thanks again for the fix. Just ignore this post.


Best regards,
Liu Po
- 8038

-----Original Message-----
From: Gala Kumar-B11780=20
Sent: Wednesday, February 20, 2013 12:01 AM
To: Liu Po-B43644
Cc: <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc/85xx: dts - add ranges property for SEC


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

- k
