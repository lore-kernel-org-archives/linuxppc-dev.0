Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 61EFC1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 14:41:23 +1100 (EST)
Subject: Re: [PATCH v2] Integrated Flash Controller support
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1320053901-23801-1-git-send-email-b35362@freescale.com>
Date: Tue, 22 Nov 2011 21:41:00 -0600
Message-Id: <CCF7C6DB-437C-4140-894F-2F497AD610DC@kernel.crashing.org>
References: <1320053901-23801-1-git-send-email-b35362@freescale.com>
To: Artem.Bityutskiy@nokia.com, David Woodhouse <dwmw2@infradead.org>
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "b35362@freescale.com>" <b35362@freescale.com>,
 "linux-kernel@vger.kernel.org Kernel" <linux-kernel@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Scott Wood <scottwood@freescale.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 31, 2011, at 4:38 AM, <b35362@freescale.com> =
<b35362@freescale.com> wrote:

> From: Liu Shuo <b35362@freescale.com>
>=20
> Integrated Flash Controller supports various flashes like NOR, NAND
> and other devices using NOR, NAND and GPCM Machine available on it.
> IFC supports four chip selects.
>=20
> Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Liu Shuo <b35362@freescale.com>
> ---
> arch/powerpc/Kconfig               |    4 +
> arch/powerpc/include/asm/fsl_ifc.h |  834 =
++++++++++++++++++++++++++++++++++++
> arch/powerpc/sysdev/Makefile       |    1 +
> arch/powerpc/sysdev/fsl_ifc.c      |  322 ++++++++++++++
> 4 files changed, 1161 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/include/asm/fsl_ifc.h
> create mode 100644 arch/powerpc/sysdev/fsl_ifc.c

Guys,

How are we handling this patchset since it touches drivers/mtd/nand?

- k=
