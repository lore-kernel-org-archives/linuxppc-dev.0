Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DDAA42C032C
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 04:53:46 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: p1022ds: fix DIU/LBC switching with NAND
 enabled
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343076212-5236-1-git-send-email-timur@freescale.com>
Date: Thu, 26 Jul 2012 13:53:44 -0500
Message-Id: <2E2533EE-1417-4FBC-82E4-FF0A0AAD5A4B@kernel.crashing.org>
References: <1343076212-5236-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 23, 2012, at 3:43 PM, Timur Tabi wrote:

> In order for indirect mode on the PIXIS to work properly, both chip =
selects
> need to be set to GPCM mode, otherwise writes to the chip select base
> addresses will not actually post to the local bus -- they'll go to the
> NAND controller instead.  Therefore, we need to set BR0 and BR1 to =
GPCM
> mode before switching to indirect mode.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |   64 =
+++++++++++++++++++++++++++++++-
> 1 files changed, 62 insertions(+), 2 deletions(-)

applied to merge

- k=
