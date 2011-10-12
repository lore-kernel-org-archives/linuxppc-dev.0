Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AF824B6F67
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2011 15:53:57 +1100 (EST)
Subject: Re: [PATCH v3] powerpc/85xx: Adding DCSR node to dtsi device trees
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1316187394-858-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 11 Oct 2011 23:53:51 -0500
Message-Id: <24B22B94-9388-4638-9629-87DD547097AE@kernel.crashing.org>
References: <1316187394-858-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Stephen George <stephen.george@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 16, 2011, at 10:36 AM, Kumar Gala wrote:

> From: Stephen George <stephen.george@freescale.com>
> 
> Adding new device tree binding file for the DCSR node.  Modifying device
> tree dtsi files to add DCSR node for P2041, P3041, P3060, P4080, & P5020.
> 
> Signed-off-by: Stephen George <stephen.george@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> v3:
> * fix IRQs #, (should be +16 because of external IRQs starting at 0)
> 
> v2:
> * include dscr.txt binding spec
> * moved around dcsr nodes to keep sorted in addr order

applied, dropped p3060 for now (will pick up in the P3060QDS board patch).

- k
