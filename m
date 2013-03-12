Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1F1342C030E
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Mar 2013 08:17:06 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r2CLGt1t002377
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Mar 2013 16:17:03 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1278)
Subject: Re: [PATCH 2/8] powerpc/85xx: Add support for FSL PCIe controller v3.0
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
Date: Tue, 12 Mar 2013 16:15:36 -0500
Message-Id: <7E21EA55-74B5-4359-8F6F-73E207FF1AC6@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2013, at 5:15 PM, Kumar Gala wrote:

> From: Roy ZANG <tie-fei.zang@freescale.com>
> 
> The T4240 utilizes a new PCIe controller block that has some minor
> programming model differences from previous versions.
> 
> The major one that impacts initialization is how we determine the link
> state.  On the 3.x controllers we have a memory mapped SoC register
> instead of a PCI config register that reports the link state.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/sysdev/fsl_pci.c |   29 ++++++++++++++++++++++++++---
> arch/powerpc/sysdev/fsl_pci.h |   11 +++++++++++
> 2 files changed, 37 insertions(+), 3 deletions(-)

applied to next

- k
