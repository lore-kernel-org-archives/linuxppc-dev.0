Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3AC0DB6F13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 07:22:39 +1100 (EST)
Subject: Re: [PATCH 6/9] powerpc/mpc8548cds: Add FPGA node to dts
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331024805-15926-5-git-send-email-chenhui.zhao@freescale.com>
Date: Fri, 16 Mar 2012 15:22:35 -0500
Message-Id: <AD58BFAB-F200-4441-960C-CC65AC5B0D70@kernel.crashing.org>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
 <1331024805-15926-5-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 3:06 AM, Zhao Chenhui wrote:

> From: chenhui zhao <chenhui.zhao@freescale.com>
>=20
> Remove FPGA(CADMUS) macros in code. Move it to dts.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8548cds.dts      |    8 ++++-
> arch/powerpc/platforms/85xx/mpc85xx_cds.c |   50 =
+++++++++++++++++++---------
> 2 files changed, 41 insertions(+), 17 deletions(-)

applied

- k=
