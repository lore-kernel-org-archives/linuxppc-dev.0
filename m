Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40968B70EA
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Sep 2010 07:44:39 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add P1021 PCI IDs and quirks
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100808140333.GA4706@oksana.dev.rtsoft.ru>
Date: Tue, 31 Aug 2010 16:44:34 -0500
Message-Id: <F9852CAD-0739-463D-A833-029078DEBD37@kernel.crashing.org>
References: <20100808140333.GA4706@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 8, 2010, at 9:03 AM, Anton Vorontsov wrote:

> This is needed for proper PCI-E support on P1021 SoCs.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |    2 ++
> include/linux/pci_ids.h       |    2 ++
> 2 files changed, 4 insertions(+), 0 deletions(-)

applied

- k
