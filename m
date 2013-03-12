Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 678AF2C031A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 08:14:42 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Reserve a partition of NOR flash for QE
 ucode firmware
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1361846016-9023-1-git-send-email-Jiucheng.Xu@freescale.com>
Date: Tue, 12 Mar 2013 16:14:35 -0500
Message-Id: <19C5CD22-0284-45E8-A791-4DE017328209@kernel.crashing.org>
References: <1361846016-9023-1-git-send-email-Jiucheng.Xu@freescale.com>
To: Jiucheng Xu <Jiucheng.Xu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 25, 2013, at 8:33 PM, Jiucheng Xu wrote:

> Due to the partition of JFFS2 overlaps with QE ucode firmware, So JFFS2
> will break QE ucode. Shrink JFFS2's partition to reserve the space of
> QE ucode firmware.
> 
> Signed-off-by: Jiucheng Xu <Jiucheng.Xu@freescale.com>
> ---
> arch/powerpc/boot/dts/p1021rdb-pc.dtsi |   12 ++++++++++--
> 1 files changed, 10 insertions(+), 2 deletions(-)

applied to next

- k
