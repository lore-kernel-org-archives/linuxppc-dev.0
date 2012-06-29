Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C294CB702E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 06:03:18 +1000 (EST)
Subject: Re: [PATCH 2/4] powerpc/83xx: fix RGMII AC values workaround for
 km83xx
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1336485442-24190-2-git-send-email-holger.brunck@keymile.com>
Date: Fri, 29 Jun 2012 15:03:13 -0500
Message-Id: <6E5EF9C6-D472-4E72-B1FB-E949CB618953@kernel.crashing.org>
References: <1336485442-24190-1-git-send-email-holger.brunck@keymile.com>
 <1336485442-24190-2-git-send-email-holger.brunck@keymile.com>
To: Holger Brunck <holger.brunck@keymile.com>
Cc: Christian Herzig <christian.herzig@keymile.com>,
 linuxppc-dev@lists.ozlabs.org, Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 8, 2012, at 8:57 AM, Holger Brunck wrote:

> From: Christian Herzig <christian.herzig@keymile.com>
>=20
> Fix RGMII workaround code in km83xx.c for MPC8360E and MPC8358E that =
it
> correctly identifes all affected SoC chip models and applies the
> workarounds appropriate for 2.0 and 2.1 revisions as per Freescale
> MPC8360ECE Errata document Rev.5(9/2011) item QE_ENET10.
>=20
> Signed-off-by: Christian Herzig <christian.herzig@keymile.com>
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> cc: Heiko Schocher <hs@denx.de>
> cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/platforms/83xx/km83xx.c |   98 =
+++++++++++++++++++++++-----------
> 1 files changed, 66 insertions(+), 32 deletions(-)

applied

- k=
