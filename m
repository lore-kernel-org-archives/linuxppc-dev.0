Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8CCF6B6EEF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:07:05 +1100 (EST)
Subject: Re: [PATCH 2/2 V3] powerpc/85xx: Add p2020rdb-pc dts support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1328860797-9283-1-git-send-email-b29983@freescale.com>
Date: Fri, 16 Mar 2012 10:06:53 -0500
Message-Id: <058890AD-9F3C-46D5-A05D-5B8F0F73A998@kernel.crashing.org>
References: <1328860797-9283-1-git-send-email-b29983@freescale.com>
To: "<b29983@freescale.com>" <b29983@freescale.com>
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Prabhakar Kushwaha <prabhakar@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 10, 2012, at 1:59 AM, <b29983@freescale.com> =
<b29983@freescale.com> wrote:

> From: Tang Yuantian <Yuantian.Tang@freescale.com>
>=20
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Tang Yuantian <b29983@freescale.com>
> ---
> v3:
> 	-correct the patch author
>=20
> arch/powerpc/boot/dts/p2020rdb-pc.dtsi    |  241 =
+++++++++++++++++++++++++++++
> arch/powerpc/boot/dts/p2020rdb-pc_32b.dts |   96 ++++++++++++
> arch/powerpc/boot/dts/p2020rdb-pc_36b.dts |   96 ++++++++++++
> 3 files changed, 433 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
> create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc_36b.dts

applied

- k=
