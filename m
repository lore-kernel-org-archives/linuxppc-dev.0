Return-Path: <Kumar.Gala@freescale.com>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BDF32B6FA9
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 03:21:01 +1100 (EST)
Subject: Re: [PATCH 3/3] [v2] powerpc/85xx: p1022ds: enable monitor switching
 via pixis indirect mode
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <Kumar.Gala@freescale.com>
In-Reply-To: <1321638601-6861-3-git-send-email-timur@freescale.com>
Date: Fri, 16 Mar 2012 11:20:56 -0500
Message-Id: <5E369A6C-BF25-490B-8B4E-05ED7B800FD7@freescale.com>
References: <1321638601-6861-1-git-send-email-timur@freescale.com>
 <1321638601-6861-3-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 18, 2011, at 11:50 AM, Timur Tabi wrote:

> When the P1022's DIU video controller is active, the pixis must be =
accessed
> in "indirect" mode, which uses localbus chip select addresses.
>=20
> Switching between the DVI and LVDS monitor ports is handled by the =
pixis,
> so that switching needs to be done via indirect mode.
>=20
> This has the side-effect of no longer requiring U-Boot to enable the =
DIU.
> Now Linux can enable the DIU all by itself.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |  132 =
++++++++++++++++++++++++++-----
> 1 files changed, 110 insertions(+), 22 deletions(-)

applied

- k=
