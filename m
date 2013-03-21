Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0421C2C058B
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Mar 2013 20:06:12 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc/fsl-booke: Added device tree DCSR entries for
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363633870-3894-1-git-send-email-galak@kernel.crashing.org>
Date: Thu, 21 Mar 2013 04:06:09 -0500
Message-Id: <AD49EF13-54BA-4CF0-AC08-2C1C2D4BA4AB@kernel.crashing.org>
References: <1363633870-3894-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Stephen George <Stephen.George@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2013, at 2:11 PM, Kumar Gala wrote:

> From: Stephen George <Stephen.George@freescale.com>
>=20
> Signed-off-by: Stephen George <Stephen.George@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  131 =
+++++++++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  |   25 ++---
> arch/powerpc/boot/dts/t4240qds.dts          |    4 +
> 3 files changed, 148 insertions(+), 12 deletions(-)

applied to next

- k=
