Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C2274B7101
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:49:01 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc/dts: Add magic-packet properties for etsec
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326794391-6105-2-git-send-email-X.Xie@freescale.com>
Date: Fri, 16 Mar 2012 10:48:38 -0500
Message-Id: <66D3A796-5C32-46EF-ACE6-6B510B3279EC@kernel.crashing.org>
References: <y> <1326794391-6105-1-git-send-email-X.Xie@freescale.com>
 <1326794391-6105-2-git-send-email-X.Xie@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 17, 2012, at 3:59 AM, Xie Xiaobo wrote:

> The properties indicates that the hardware supports waking up via =
magic packet.
>=20
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi |    3 ++-
> arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi |    3 ++-
> arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi |    3 ++-
> arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi |    3 ++-
> 4 files changed, 8 insertions(+), 4 deletions(-)

applied

- k=
