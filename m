Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F5811007F5
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 14:12:33 +1000 (EST)
Subject: Re: [PATCH] powerpc/p1022ds: Remove fixed-link property from ethernet
	nodes.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1310024270-2675-1-git-send-email-felix@embedded-sol.com>
Date: Thu, 7 Jul 2011 23:12:20 -0500
Message-Id: <4C2A220E-EE6C-4693-9314-FE52701CCE49@kernel.crashing.org>
References: <1310024270-2675-1-git-send-email-felix@embedded-sol.com>
To: Felix Radensky <felix@embedded-sol.com>
Cc: linuxppc-dev@ozlabs.org, B04825@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 7, 2011, at 2:37 AM, Felix Radensky wrote:

> On P1022DS both ethernet controllers are connected to RGMII PHYs
> accessible via MDIO bus. Remove fixed-link property from ethernet
> nodes as they only required when fixed link PHYs without MDIO bus
> are used.
> 
> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
> ---
> arch/powerpc/boot/dts/p1022ds.dts |    2 --
> 1 files changed, 0 insertions(+), 2 deletions(-)

applied to next
