Return-Path: <B20052@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E632D2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 18:01:02 +1100 (EST)
From: Leekha Shaveta-B20052 <B20052@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 4/6] powerpc/fsl-booke: Add initial B4420QDS board
 device tree
Date: Mon, 18 Mar 2013 07:00:51 +0000
Message-ID: <E12D2F89F87F4A49B0320A4C2DE7E749144ACE@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <1363334109-21922-4-git-send-email-shaveta@freescale.com>
 <78325CC6-01B7-4A81-A4E9-40188B7994DE@kernel.crashing.org>
In-Reply-To: <78325CC6-01B7-4A81-A4E9-40188B7994DE@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Saturday, March 16, 2013 2:02 AM
To: Leekha Shaveta-B20052
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/6] powerpc/fsl-booke: Add initial B4420QDS board devi=
ce tree


On Mar 15, 2013, at 2:55 AM, Shaveta Leekha wrote:

> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> ---
> arch/powerpc/boot/dts/b4420qds.dts |  168=20
> ++++++++++++++++++++++++++++++++++++
> 1 files changed, 168 insertions(+), 0 deletions(-) create mode 100644=20
> arch/powerpc/boot/dts/b4420qds.dts

If B4420 and B4860 qds are same board, refactor this into a b4qds.dtsi file=
 for common board features like NOR, NAND, SPI, SDHC, etc.

[SL] will work on refactoring and send new set of patches soon. Thanks for =
the feedback.

Regards,
Shaveta
=20
- k
