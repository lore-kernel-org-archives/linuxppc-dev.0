Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 331A3B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 22:45:07 +1100 (EST)
Subject: Re: [PATCH] powerpc/dts: fix the compatible string of sec 4.0
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331018476-27798-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Tue, 6 Mar 2012 05:45:00 -0600
Message-Id: <093ED4E3-CF1A-47EF-AE67-D1C6A340BFDA@kernel.crashing.org>
References: <1331018476-27798-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shuo <shuo.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 1:21 AM, Shengzhou Liu wrote:

> From: Liu Shuo <shuo.liu@freescale.com>
>=20
> Fix the compatible string of sec 4.0 to match with CAMM driver =
according
> to the documentation file =
Documentation/devicetree/bindings/crypto/fsl-sec4.txt.
>=20
> Signed-off-by: Liu Shuo <shuo.liu@freescale.com>
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> against master branch of =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>=20
> arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi |   10 +++++-----
> 1 files changed, 5 insertions(+), 5 deletions(-)

Kim,

Please ack or nack this.

- k=
