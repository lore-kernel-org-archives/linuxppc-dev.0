Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5A4962C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 00:52:21 +1000 (EST)
Subject: Re: [PATCH] powerpc/fsl-pci: fix warning when CONFIG_SWIOTLB is
 disabled
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1347962268-25136-1-git-send-email-B38951@freescale.com>
Date: Wed, 19 Sep 2012 09:51:50 -0500
Message-Id: <AD0950A2-D500-4011-9048-A8467AD153A8@kernel.crashing.org>
References: <1347962268-25136-1-git-send-email-B38951@freescale.com>
To: Jia Hongtao <B38951@freescale.com>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 18, 2012, at 4:57 AM, Jia Hongtao wrote:

> Fix the following warning:
> arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_probe':
> arch/powerpc/sysdev/fsl_pci.c:867:25: error: unused variable 'hose'
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)

applied to next

- k
