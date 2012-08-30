Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A32442C0136
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2012 02:07:16 +1000 (EST)
Subject: Re: [PATCH] powerpc/8544ds: add partition table for norflash
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1346209249-5049-1-git-send-email-Dongsheng.wang@freescale.com>
Date: Thu, 30 Aug 2012 11:07:10 -0500
Message-Id: <7D2CD2DE-279D-4F00-8303-F481FC521D75@kernel.crashing.org>
References: <1346209249-5049-1-git-send-email-Dongsheng.wang@freescale.com>
To: "<Dongsheng.wang@freescale.com>" <Dongsheng.wang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 28, 2012, at 10:00 PM, <Dongsheng.wang@freescale.com> =
<Dongsheng.wang@freescale.com> wrote:

> From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
>=20
> create partition table for norflash.
>=20
> Signed-off-by: Wang Dongsheng <Dongsheng.Wang@freescale.com>
> ---
>=20
> arch/powerpc/boot/dts/mpc8544ds.dts  |    4 ++-
> arch/powerpc/boot/dts/mpc8544ds.dtsi |   38 =
++++++++++++++++++++++++++++++++++
> 2 files changed, 41 insertions(+), 1 deletions(-)

Added read-only to u-boot partition.

applied to next

- k=
