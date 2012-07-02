Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 652D22C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 03:54:09 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/mpc85xx: p1022ds support the MTD for NOR and
 NAND flash
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1334626955-8069-1-git-send-email-Chang-Ming.Huang@freescale.com>
Date: Mon, 2 Jul 2012 12:54:03 -0500
Message-Id: <13C02C19-F509-45F9-B8D7-6081E3748642@kernel.crashing.org>
References: <1334626955-8069-1-git-send-email-Chang-Ming.Huang@freescale.com>
To: "<Chang-Ming.Huang@freescale.com>" <Chang-Ming.Huang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 16, 2012, at 8:42 PM, <Chang-Ming.Huang@freescale.com> =
<Chang-Ming.Huang@freescale.com> wrote:

> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>=20
> The compatilbe 'simple-bus' is removed from the latest DTS for NAND =
and
> NOR flash partition, so we must add the new compatilbe support for =
p1022ds,
> otherwise, the kernel can't parse the partition of NOR and NAND flash.
>=20
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

If this is still relevant, please resubmit against my powerpc.git 'next' =
branch.

- k=
