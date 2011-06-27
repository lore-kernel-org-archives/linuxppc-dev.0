Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57DECB6F53
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 23:35:43 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add P4080 SoC device tree include stub
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1308830770-1954-1-git-send-email-galak@kernel.crashing.org>
Date: Mon, 27 Jun 2011 08:35:19 -0500
Message-Id: <4C014C71-3273-430B-99F8-C8D49596DD3A@kernel.crashing.org>
References: <1308830770-1954-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 23, 2011, at 7:06 AM, Kumar Gala wrote:

> Split out common (non-board specific) parts of the SoC related device
> tree into a stub so multiple board dts files can include it and we can
> reduce duplication and maintenance effort.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/p4080ds.dts  |  588 =
+--------------------------------
> arch/powerpc/boot/dts/p4080si.dtsi |  661 =
++++++++++++++++++++++++++++++++++++
> 2 files changed, 662 insertions(+), 587 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/p4080si.dtsi

applied to next

- K=
