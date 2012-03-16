Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 79B9AB6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:48:36 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc/dts: Add some DTS nodes and attributes for
 mpc8536ds
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326794391-6105-1-git-send-email-X.Xie@freescale.com>
Date: Fri, 16 Mar 2012 10:48:30 -0500
Message-Id: <C28592BE-FCA8-484E-A94E-42832DF29C9C@kernel.crashing.org>
References: <y> <1326794391-6105-1-git-send-email-X.Xie@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 17, 2012, at 3:59 AM, Xie Xiaobo wrote:

> 1. Add partitions for NOR and NAND Flash.
> 2. Additional attributes for sdhc.
>=20
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    5 ++
> arch/powerpc/boot/dts/mpc8536ds.dts           |    6 ++-
> arch/powerpc/boot/dts/mpc8536ds.dtsi          |   93 =
+++++++++++++++++++++++++
> arch/powerpc/boot/dts/mpc8536ds_36b.dts       |    8 ++-
> 4 files changed, 109 insertions(+), 3 deletions(-)

applied

- k=
