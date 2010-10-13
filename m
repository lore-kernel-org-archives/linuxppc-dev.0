Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50D51100C85
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 01:45:33 +1100 (EST)
Subject: Re: [PATCH][v2] powerpc/fsl: 85xx: add cache-sram support
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1286971256-22878-1-git-send-email-harninder.rai@freescale.com>
Date: Wed, 13 Oct 2010 09:45:25 -0500
Message-Id: <6C7FF889-5FDC-46B4-9B09-584110CE912F@kernel.crashing.org>
References: <1286971256-22878-1-git-send-email-harninder.rai@freescale.com>
To: "<harninder.rai@freescale.com>" <harninder.rai@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2010, at 7:00 AM, <harninder.rai@freescale.com> =
<harninder.rai@freescale.com> wrote:

> From: Harninder Rai <harninder.rai@freescale.com>
>=20
> It adds cache-sram support in P1/P2 QorIQ platforms as under:
>=20
>    * A small abstraction over powerpc's remote heap allocator
>    * Exports mpc85xx_cache_sram_alloc()/free() APIs
>    * Supports only one contiguous SRAM window
>    * Drivers can do the following in Kconfig to use these APIs
>        "select FSL_85XX_CACHE_SRAM if MPC85xx"
>    * Required SRAM size and the offset where SRAM should be mapped =
must be
>      provided at kernel command line as :-
>        cache-sram-size=3D<value>
>        cache-sram-offset=3D<offset>
>=20
> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
> ---
> incorporated review comments from Philipp
>=20
> arch/powerpc/include/asm/fsl_85xx_cache_sram.h |   48 +++++
> arch/powerpc/sysdev/Makefile                   |    1 +
> arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h      |  101 +++++++++++
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c      |  159 ++++++++++++++++
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c          |  231 =
++++++++++++++++++++++++
> 5 files changed, 540 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/include/asm/fsl_85xx_cache_sram.h
> create mode 100644 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
> create mode 100644 arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> create mode 100644 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c

applied to next

- k=
