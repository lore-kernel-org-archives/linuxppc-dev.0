Return-Path: <B11780@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 110EF2C007A
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2013 07:05:09 +1100 (EST)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] [v2] powerpc/fsl: remove extraneous DIU platform functions
Date: Fri, 15 Feb 2013 20:05:01 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D728A77@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1358465214-18746-1-git-send-email-timur@tabi.org>
In-Reply-To: <1358465214-18746-1-git-send-email-timur@tabi.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 17, 2013, at 5:26 PM, Timur Tabi wrote:

> From: Timur Tabi <timur@freescale.com>
>=20
> The Freescale DIU driver was recently updated to not require every DIU
> platform function, so now we can remove the unneeded functions from
> some boards.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/512x/mpc512x_shared.c |    5 ---
> arch/powerpc/platforms/85xx/p1022_ds.c       |   38 ---------------------=
-----
> arch/powerpc/platforms/85xx/p1022_rdk.c      |   12 --------
> 3 files changed, 0 insertions(+), 55 deletions(-)

applied to next

- k=
