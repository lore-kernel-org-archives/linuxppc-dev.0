Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9EC34B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 07:23:04 +1100 (EST)
Subject: Re: [PATCH 5/9] powerpc/mpc8548cds: Add RapidIO node to dts
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331024805-15926-4-git-send-email-chenhui.zhao@freescale.com>
Date: Fri, 16 Mar 2012 15:23:00 -0500
Message-Id: <B2313DBB-4A06-4917-933C-CDE462FEA37F@kernel.crashing.org>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
 <1331024805-15926-4-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 3:06 AM, Zhao Chenhui wrote:

> From: chenhui zhao <chenhui.zhao@freescale.com>
> 
> Enable RapidIO and add rapidio and rmu nodes to dts.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/mpc8548si-post.dtsi |   16 ++++++++++++++++
> arch/powerpc/boot/dts/mpc8548cds.dts          |    7 +++++++
> arch/powerpc/platforms/85xx/Kconfig           |    1 +
> 3 files changed, 24 insertions(+), 0 deletions(-)

applied

- k
