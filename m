Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6543F2C014E
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Apr 2013 23:37:09 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix MPC8536DS 36-bit device tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20130410165828.ec0378afc7e7f17e8e47850e@freescale.com>
Date: Thu, 11 Apr 2013 08:34:14 -0500
Message-Id: <4AF22D28-FA1A-4D09-94E1-9AF8AF175991@kernel.crashing.org>
References: <20130410165828.ec0378afc7e7f17e8e47850e@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 10, 2013, at 4:58 PM, Kim Phillips wrote:

> From: Kumar Gala <galak@kernel.crashing.org>
> 
> The localbus node should be in at 0xfffe05000 not 0xffe05000.  Also
> fixed the names of the localbus and pci nodes to reflect the addresses
> they are actually at.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> note: this upstream submission extended to fix pci1.
> 
> arch/powerpc/boot/dts/mpc8536ds_36b.dts | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

applied to next

- k
