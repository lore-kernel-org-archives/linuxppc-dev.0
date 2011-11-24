Return-Path: <B11780@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
 [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AFBD31007E3
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 16:16:17 +1100 (EST)
Received: from mail61-db3 (localhost [127.0.0.1])	by mail61-db3-R.bigfish.com
 (Postfix) with ESMTP id A0EE950036C	for <linuxppc-dev@ozlabs.org>;
 Thu, 24 Nov 2011 05:16:16 +0000 (UTC)
Received: from DB3EHSMHS019.bigfish.com (unknown [10.3.81.240])	by
 mail61-db3.bigfish.com (Postfix) with ESMTP id 8699D680043	for
 <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 05:16:16 +0000 (UTC)
Subject: Re: [PATCH 2/3] powerpc/85xx: add pixis indirect mode device tree node
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1321638601-6861-2-git-send-email-timur@freescale.com>
Date: Wed, 23 Nov 2011 23:16:08 -0600
Message-ID: <A429959D-8AE0-48D3-9755-840EB5F9C5B6@freescale.com>
References: <1321638601-6861-1-git-send-email-timur@freescale.com>
 <1321638601-6861-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 18, 2011, at 11:50 AM, Timur Tabi wrote:

> The Freescale P1022 has a unique pin muxing "feature" where the DIU =
video
> controller's video signals are muxed with 24 of the local bus address =
signals.
> When the DIU is enabled, the bulk of the local bus is disabled, =
preventing
> access to memory-mapped devices like NOR flash and the pixis FPGA.
>=20
> In this situation, the pixis supports "indirect mode", which allows =
access
> to the pixis itself by reading/writing addresses on specific local bus
> chip selects.  CS0 is used to select which pixis register to access, =
and
> CS1 is used to read/write the value.
>=20
> To support this, we introduce another board-control child node of the
> localbus node that contains a 'reg' property for CS0 and CS1.  This =
will
> produce the correct physical addresses for CS0 and CS1.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dts |   14 ++++++++++++++
> 1 files changed, 14 insertions(+), 0 deletions(-)

applied to next

- k=
