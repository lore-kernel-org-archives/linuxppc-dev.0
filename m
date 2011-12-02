Return-Path: <B11780@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D6ECEB6F75
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2011 10:03:38 +1100 (EST)
Received: from mail44-tx2 (localhost [127.0.0.1])	by mail44-tx2-R.bigfish.com
 (Postfix) with ESMTP id 579886801D1	for <linuxppc-dev@ozlabs.org>;
 Fri,  2 Dec 2011 23:03:35 +0000 (UTC)
Received: from TX2EHSMHS037.bigfish.com (unknown [10.9.14.235])	by
 mail44-tx2.bigfish.com (Postfix) with ESMTP id 3EC2A60024D	for
 <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 23:03:34 +0000 (UTC)
Subject: Re: [PATCH 2/2] powerpc/85xx: add a 32-bit P1022DS device tree
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1322863714-6818-2-git-send-email-timur@freescale.com>
Date: Fri, 2 Dec 2011 17:03:33 -0600
Message-ID: <D5BD2D7D-4549-42A7-8BA6-9B3C84DB5E85@freescale.com>
References: <1322863714-6818-1-git-send-email-timur@freescale.com>
 <1322863714-6818-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 2, 2011, at 4:08 PM, Timur Tabi wrote:

> Add a 32-bit version of the device tree for the Freescale P1022DS =
reference
> board.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds_32b.dts |  270 =
+++++++++++++++++++++++++++++++++
> 1 files changed, 270 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1022ds_32b.dts

look at how mpc8572ds handles 36b.dts we put common definitions in a =
shared file.

- k=
