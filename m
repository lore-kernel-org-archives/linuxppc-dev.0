Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3CBFE2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 07:30:09 +1100 (EST)
Subject: Re: [PATCH 3/6] powerpc/fsl-booke: Add initial silicon device tree
 files for B4420QDS
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363334109-21922-3-git-send-email-shaveta@freescale.com>
Date: Fri, 15 Mar 2013 15:30:13 -0500
Message-Id: <C9B89974-CDAD-4221-B1F2-9F03D8E88EB2@kernel.crashing.org>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <1363334109-21922-3-git-send-email-shaveta@freescale.com>
To: Shaveta Leekha <shaveta@freescale.com>
Cc: Andy Fleming <afleming@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 15, 2013, at 2:55 AM, Shaveta Leekha wrote:

> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |  151 =
+++++++++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   70 ++++++++++++
> 2 files changed, 221 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi

Similar comments to B4860 dts files.

- k=
