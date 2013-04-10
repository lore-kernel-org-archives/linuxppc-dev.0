Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ABCA62C04EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 01:18:16 +1000 (EST)
Subject: Re: [PATCH 2/4][v2] powerpc/fsl-booke: Add initial B4860QDS and
 B4420QDS board device tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1365143632-19362-2-git-send-email-shaveta@freescale.com>
Date: Wed, 10 Apr 2013 10:17:42 -0500
Message-Id: <2DAE879C-2165-4D73-86E7-9E85149A4607@kernel.crashing.org>
References: <1365143632-19362-1-git-send-email-shaveta@freescale.com>
 <1365143632-19362-2-git-send-email-shaveta@freescale.com>
To: Shaveta Leekha <shaveta@freescale.com>
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Andy Fleming <afleming@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 5, 2013, at 1:33 AM, Shaveta Leekha wrote:

> B4860QDS and B4420QDS share same QDS board
>=20
> * common board features have been added in b4qds.dts
> * various board differences are in respective files of B4860 and B4420
>=20
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/b4420qds.dts |   50 +++++++++++
> arch/powerpc/boot/dts/b4860qds.dts |   61 +++++++++++++
> arch/powerpc/boot/dts/b4qds.dts    |  171 =
++++++++++++++++++++++++++++++++++++
> 3 files changed, 282 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/b4420qds.dts
> create mode 100644 arch/powerpc/boot/dts/b4860qds.dts
> create mode 100644 arch/powerpc/boot/dts/b4qds.dts

applied to next

- k=
