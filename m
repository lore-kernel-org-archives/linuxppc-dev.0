Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DB67C2C00C5
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2012 23:06:03 +1000 (EST)
Subject: Re: [PATCH 2/3,
 v2] powerpc/e500mc: Add Power ISA properties to comply with ePAPR 1.1
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344498156-25127-2-git-send-email-hong-hua.yin@freescale.com>
Date: Fri, 10 Aug 2012 08:05:21 -0500
Message-Id: <A2511AC5-F1AB-4884-A5F0-CF1E7AB1EB3B@kernel.crashing.org>
References: <1344498156-25127-1-git-send-email-hong-hua.yin@freescale.com>
 <1344498156-25127-2-git-send-email-hong-hua.yin@freescale.com>
To: Olivia Yin <hong-hua.yin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 9, 2012, at 2:42 AM, Olivia Yin wrote:

> power-isa-version and power-isa-* are cpu node general properties =
defined in ePAPR.
>=20
> If the power-isa-version property exists, then for each category from =
the=20
> Categories section of Book I of the Power ISA version indicated, the=20=

> existence of a property named power-isa-[CAT], where [CAT] is the=20
> abbreviated category name with all uppercase letters converted to=20
> lowercase, indicates that the category is supported by the =
implementation.
>=20
> The patch update all the e500mc platforms.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> Signed-off-by: Olivia Yin <hong-hua.yin@freescale.com>
> ---
> git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> branch: next
>=20
> arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi |   58 =
+++++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi      |    3 +
> arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi      |    3 +
> arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi      |    3 +
> 4 files changed, 67 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/fsl/e500mc_power_isa.dtsi

applied to next

- k=
