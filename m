Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D245B72C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 02:35:27 +1100 (EST)
Subject: Re: [PATCH 3/5,v3] powerpc/85xx: Update SRIO device tree nodes
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1321099352-21462-3-git-send-email-Gang.Liu@freescale.com>
Date: Wed, 16 Nov 2011 09:35:11 -0600
Message-Id: <F2C5B7D0-98F0-45C2-A9CA-EF6A783B4485@kernel.crashing.org>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
 <1321099352-21462-3-git-send-email-Gang.Liu@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: r58472@freescale.com, linux-kernel@vger.kernel.org, r61911@freescale.com,
 Alexandre.Bounine@idt.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 12, 2011, at 6:02 AM, Liu Gang wrote:

> From: Kumar Gala <galak@kernel.crashing.org>
>=20
> Update all dts files that support SRIO controllers to match the new
> fsl,srio device tree binding.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/mpc8568mds.dts   |   66 =
++++++++++++++++++++++-------
> arch/powerpc/boot/dts/mpc8569mds.dts   |   72 =
+++++++++++++++++++++++++------
> arch/powerpc/boot/dts/mpc8641_hpcn.dts |   69 =
++++++++++++++++++++++++-------
> arch/powerpc/boot/dts/p2041rdb.dts     |   11 +++++
> arch/powerpc/boot/dts/p2041si.dtsi     |   20 +++++++++
> arch/powerpc/boot/dts/p3041ds.dts      |   11 +++++
> arch/powerpc/boot/dts/p3041si.dtsi     |   26 ++++++++---
> arch/powerpc/boot/dts/p4080ds.dts      |   12 ++++-
> arch/powerpc/boot/dts/p4080si.dtsi     |   64 =
+++++++++++++++++++++++-----
> arch/powerpc/boot/dts/p5020ds.dts      |   11 +++++
> arch/powerpc/boot/dts/p5020si.dtsi     |   26 ++++++++---
> 11 files changed, 314 insertions(+), 74 deletions(-)

I'm holding off on this, since I'm reworking the .dts.  I'll workup a =
new patch based on top of the dts changes.

- k=
