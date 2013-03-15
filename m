Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 05A572C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 07:31:30 +1100 (EST)
Subject: Re: [PATCH 4/6] powerpc/fsl-booke: Add initial B4420QDS board device
 tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363334109-21922-4-git-send-email-shaveta@freescale.com>
Date: Fri, 15 Mar 2013 15:31:36 -0500
Message-Id: <78325CC6-01B7-4A81-A4E9-40188B7994DE@kernel.crashing.org>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
 <1363334109-21922-4-git-send-email-shaveta@freescale.com>
To: Shaveta Leekha <shaveta@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
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
> ---
> arch/powerpc/boot/dts/b4420qds.dts |  168 =
++++++++++++++++++++++++++++++++++++
> 1 files changed, 168 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/b4420qds.dts

If B4420 and B4860 qds are same board, refactor this into a b4qds.dtsi =
file for common board features like NOR, NAND, SPI, SDHC, etc.

- k=
