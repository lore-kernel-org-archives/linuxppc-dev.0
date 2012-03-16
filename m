Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A5580B70B3
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 02:49:05 +1100 (EST)
Subject: Re: [PATCH 2/2] [v4] powerpc/85xx: create 32-bit DTS for the P1022DS
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1329351948-20581-2-git-send-email-timur@freescale.com>
Date: Fri, 16 Mar 2012 10:48:46 -0500
Message-Id: <4D3FB264-8E13-4296-A7F7-8849835005C9@kernel.crashing.org>
References: <1329351948-20581-1-git-send-email-timur@freescale.com>
 <1329351948-20581-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 15, 2012, at 6:25 PM, Timur Tabi wrote:

> Create a 32-bit address space version of p1022ds.dts.  To avoid =
confusion,
> p1022ds.dts is renamed to p1022ds_36b.dts.  We also create =
p1022ds.dtsi
> to store some common nodes.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dts     |  274 =
---------------------------------
> arch/powerpc/boot/dts/p1022ds.dtsi    |  234 =
++++++++++++++++++++++++++++
> arch/powerpc/boot/dts/p1022ds_32b.dts |  103 ++++++++++++
> arch/powerpc/boot/dts/p1022ds_36b.dts |  103 ++++++++++++
> 4 files changed, 440 insertions(+), 274 deletions(-)
> delete mode 100644 arch/powerpc/boot/dts/p1022ds.dts
> create mode 100644 arch/powerpc/boot/dts/p1022ds.dtsi
> create mode 100644 arch/powerpc/boot/dts/p1022ds_32b.dts
> create mode 100644 arch/powerpc/boot/dts/p1022ds_36b.dts

applied

- k=
