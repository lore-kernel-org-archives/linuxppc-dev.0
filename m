Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E65041009F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 09:41:48 +1100 (EST)
Subject: Re: [PATCH] powerpc/dts: update dts for p1020rdb
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326362665-9715-1-git-send-email-B32736@freescale.com>
Date: Tue, 17 Jan 2012 16:41:50 -0600
Message-Id: <11EACF46-96B0-467B-B397-7443EA3802B5@kernel.crashing.org>
References: <y> <1326362665-9715-1-git-send-email-B32736@freescale.com>
To: Zhicheng Fan <B32736@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 12, 2012, at 4:04 AM, Zhicheng Fan wrote:

> nand: Sync base address with U-boot
> sdhc: Add suppot auto cmd12
> 
> Signed-off-by: Zhicheng Fan <B32736@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/p1020si-post.dtsi |    3 +++
> arch/powerpc/boot/dts/p1020rdb.dts          |    2 +-
> arch/powerpc/boot/dts/p1020rdb_36b.dts      |    2 +-
> 3 files changed, 5 insertions(+), 2 deletions(-)

applied to merge

- k
