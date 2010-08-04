Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3CDAB100E27
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:24:01 +1000 (EST)
Subject: Re: [PATCH v2 0/2] Adding DTS for the STx GP3-SSA MPC8555 board
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AANLkTimMb_PshxAIDvbfFdbCqHrlY13Qiz9g2eZ1vw1E@mail.gmail.com>
Date: Wed, 4 Aug 2010 14:23:53 -0500
Message-Id: <6E9CBDC8-3530-4527-955A-7EA9DF102204@kernel.crashing.org>
References: <AANLkTimMb_PshxAIDvbfFdbCqHrlY13Qiz9g2eZ1vw1E@mail.gmail.com>
To: Bradley Hughes <bhughes@silicontkx.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 21, 2010, at 5:04 PM, Bradley Hughes wrote:

> This version uses "fsl,mpc8555..." instead of "fsl,85..." notation.
>=20
> There is also an 8541 version of this board so DTS for this board
> is specific to the 8555 processor.
>=20
> Another patch is coming to fix-up other DTS that use old notation.
>=20
> Signed-off-by: Bradley Hughes <bhughes@silicontkx.com>
> ---
> arch/powerpc/boot/dts/stxssa8555.dts |  380 =
++++++++++++++++++++++++++++++++++
> 1 files changed, 380 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/stxssa8555.dts

applied to next

- k=
