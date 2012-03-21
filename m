Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4AC5BB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 04:22:31 +1100 (EST)
Subject: Re: [PATCH 3/4 v2] powerpc/85xx: add the P1020MBG-PC DTS support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332224685-1012-1-git-send-email-Chang-Ming.Huang@freescale.com>
Date: Wed, 21 Mar 2012 12:22:29 -0500
Message-Id: <B582B0CD-DA4F-4834-B251-71D56F576A3A@kernel.crashing.org>
References: <1332224685-1012-1-git-send-email-Chang-Ming.Huang@freescale.com>
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
> arch/powerpc/boot/dts/p1020mbg-pc.dtsi    |  151 =
+++++++++++++++++++++++++++++
> arch/powerpc/boot/dts/p1020mbg-pc_32b.dts |   89 +++++++++++++++++
> arch/powerpc/boot/dts/p1020mbg-pc_36b.dts |   89 +++++++++++++++++
> 3 files changed, 329 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p1020mbg-pc.dtsi
> create mode 100644 arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
> create mode 100644 arch/powerpc/boot/dts/p1020mbg-pc_36b.dts

applied

- k=
