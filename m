Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BF9F2B6FE9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 04:22:22 +1100 (EST)
Subject: Re: [PATCH 4/4 v2] powerpc/85xx: add the P1020UTM-PC DTS support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332224685-1012-2-git-send-email-Chang-Ming.Huang@freescale.com>
Date: Wed, 21 Mar 2012 12:22:21 -0500
Message-Id: <923E3AAB-3FF1-42C5-9325-CAB521CA7FCD@kernel.crashing.org>
References: <1332224685-1012-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1332224685-1012-2-git-send-email-Chang-Ming.Huang@freescale.com>
To: "<Chang-Ming.Huang@freescale.com>" <Chang-Ming.Huang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 20, 2012, at 1:24 AM, <Chang-Ming.Huang@freescale.com> =
<Chang-Ming.Huang@freescale.com> wrote:

> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>=20
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
> changes for v2:
> 	- remove the lable "read-only" for DTB and kernel partition
> 	- remove the word "RO" or "RW" from the "lable" option
>=20
> arch/powerpc/boot/dts/p1020utm-pc.dtsi    |  140 =
+++++++++++++++++++++++++++++
> arch/powerpc/boot/dts/p1020utm-pc_32b.dts |   89 ++++++++++++++++++
> arch/powerpc/boot/dts/p1020utm-pc_36b.dts |   89 ++++++++++++++++++
> 3 files changed, 318 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1020utm-pc.dtsi
> create mode 100644 arch/powerpc/boot/dts/p1020utm-pc_32b.dts
> create mode 100644 arch/powerpc/boot/dts/p1020utm-pc_36b.dts

applied

- k=
