Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2B703B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 07:00:58 +1100 (EST)
Subject: Re: [PATCH 2/2 v6] powerpc/85xx: Abstract common define of signal
 multiplex control for qe
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1329889447-1756-2-git-send-email-B32736@freescale.com>
Date: Fri, 16 Mar 2012 15:00:54 -0500
Message-Id: <AA343799-AF19-4C00-9C05-D524B9C4715B@kernel.crashing.org>
References: <1329889447-1756-1-git-send-email-B32736@freescale.com>
 <1329889447-1756-2-git-send-email-B32736@freescale.com>
To: Zhicheng Fan <B32736@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 21, 2012, at 11:44 PM, Zhicheng Fan wrote:

> From: Zhicheng Fan <b32736@freescale.com>
>=20
> The mpc85xx_rdb and mpc85xx_mds have commom define of signal multiplex =
for qe, so
> they need to go in common header, the patch abstract them to =
fsl_guts.h
>=20
> Signed-off-by: Zhicheng Fan <b32736@freescale.com>
> ---
> arch/powerpc/include/asm/fsl_guts.h       |    6 ++++-
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |   35 =
++++++++++++----------------
> 2 files changed, 20 insertions(+), 21 deletions(-)

applied

- k=
