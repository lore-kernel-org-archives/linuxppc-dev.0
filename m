Return-Path: <B11780@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7267CB6F6F
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2011 15:53:20 +1100 (EST)
Subject: Re: [PATCH] [v3] powerpc/85xx: clean up FPGA device tree nodes for
 Freecsale QorIQ boards
MIME-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1316109853-6665-1-git-send-email-timur@freescale.com>
Date: Tue, 11 Oct 2011 23:53:15 -0500
Message-ID: <A52503AA-0708-4314-B8A1-3168EF963252@freescale.com>
References: <1316109853-6665-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 15, 2011, at 1:04 PM, Timur Tabi wrote:

> Standarize and document the FPGA nodes used on Freescale QorIQ =
reference
> boards.  There are different kinds of FPGAs used on the boards, but
> only two are currently standard: "pixis", "ngpixis", and "qixis".  =
Although
> there are minor differences among the boards that have one kind of =
FPGA, most
> of the functionality is the same, so it makes sense to create common
> compatibility strings.
>=20
> We also need to update the P1022DS platform file, because the =
compatible
> string for its PIXIS node has changed.  This means that older kernels =
are
> not compatible with newer device trees.  This is not a real problem, =
however,
> since that particular function doesn't work anyway.  When the DIU is =
active,
> the PIXIS is in "indirect mode", and so cannot be accessed as a =
memory-mapped
> device.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> v3: added "ngpixis" to list
>=20
> v2: removed references to the CPLD
>=20
> This patch only adds "ngpixis" nodes, because that's the easiest.  The
> P3060QDS device tree already has a qixis node.  Support for older =
boards
> with the old "pixis" will be added later.

applied

- k=
