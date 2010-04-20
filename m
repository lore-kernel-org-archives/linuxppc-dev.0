Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78385B8312
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 14:15:36 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: 83xx: configure SIL SATA driver in 83xx-wide
	defconfig
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100415185913.2a52e1b3.kim.phillips@freescale.com>
Date: Mon, 19 Apr 2010 23:15:28 -0500
Message-Id: <BA4FFA44-C7EF-479A-8603-6D274B8680E9@kernel.crashing.org>
References: <20100415185913.2a52e1b3.kim.phillips@freescale.com>
To: Kim Phillips <Kim.Phillips@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2010, at 6:59 PM, Kim Phillips wrote:

> to enable the storage controller on earlier rev. mpc834x itx boards.
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/configs/mpc83xx_defconfig |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to merge.

- k
