Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6D3832C0453
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 23:55:01 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix pci base address error for p2020rdb-pc
 in dts
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342146455-27729-2-git-send-email-b29983@freescale.com>
Date: Fri, 13 Jul 2012 08:55:02 -0500
Message-Id: <92C3C4FF-8A63-4E15-AEEF-E112E7560E55@kernel.crashing.org>
References: <1342146455-27729-1-git-send-email-b29983@freescale.com>
 <1342146455-27729-2-git-send-email-b29983@freescale.com>
To: "<b29983@freescale.com>" <b29983@freescale.com>
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 12, 2012, at 9:27 PM, <b29983@freescale.com> =
<b29983@freescale.com> wrote:

> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>=20
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> arch/powerpc/boot/dts/p2020rdb-pc_32b.dts |    4 ++--
> arch/powerpc/boot/dts/p2020rdb-pc_36b.dts |    4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)

applied to next

- k=
