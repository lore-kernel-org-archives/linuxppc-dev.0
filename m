Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66DB2B71CD
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 14:38:59 +1000 (EST)
Subject: Re: [GIT PULL] Please pull powerpc.git next branch
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <alpine.LFD.2.00.1105192230380.2641@right.am.freescale.net>
Date: Thu, 19 May 2011 23:38:48 -0500
Message-Id: <4960E925-BC44-4059-8CC4-2A986D94E1F1@kernel.crashing.org>
References: <alpine.LFD.2.00.1105192230380.2641@right.am.freescale.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 19, 2011, at 10:31 PM, Kumar Gala wrote:

> The following changes since commit =
f38aa708776aefd9e3ba7ec1211c07efe9fa3227:
>=20
>  powerpc: Remove last piece of GEMINI (2011-05-19 17:32:29 +1000)
>=20
> are available in the git repository at:
>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next
>=20
> Bhaskar Upadhaya (1):
>      powerpc: Adding bindings for flexcan controller
>=20
> Dipen Dudhat (1):
>      powerpc: Integrated Flash controller device tree bindings
>=20
> Geert Uytterhoeven (1):
>      powerpc/mpc8610_hpcd: Do not use "/" in interrupt names
>=20
> Kumar Gala (1):
>      powerpc/fsl-booke64: Add support for Debug Level exception =
handler
>=20
> Prabhakar Kushwaha (4):
>      powerpc/85xx: P1020 DTS : re-organize dts files
>      powerpc/85xx: P2020 DTS: re-organize dts files
>      powerpc/85xx: Fix PCIe IDSEL for Px020RDB
>      powerpc/85xx: Create dts of each core in CAMP mode for P1020RDB
>=20
> Scott Wood (7):
>      powerpc/e5500: set non-base IVORs
>      powerpc: Add fsl mpic timer binding
>      powerpc/p1022ds: fix broken mpic timer node
>      powerpc/mpic: parse 4-cell intspec types other than zero
>      powerpc/mpic: add the mpic global timer support
>      powerpc/e5500: add networking to defconfig
>      powerpc/fsl: enable verbose bug output
>=20
> Shengzhou Liu (1):
>      powerpc/fsl_lbc: Add workaround for ELBC-A001 erratum
>=20
> Timur Tabi (1):
>      powerpc/86xx: don't pretend that we support 8-bit pixels on the =
MPC8610 HPCD

I might have 2 RIO patches that have been on the list for several =
months.  Waiting to hear back from Alex.

- k=
