Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D825DDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 04:21:10 +1100 (EST)
Message-Id: <3CE8ECBF-E5DA-4BF5-BB17-0D0952C7F4DA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081229164032.GA8215@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/4] powerpc/fsl_pci: Fix sparse warnings
Date: Tue, 30 Dec 2008 11:18:57 -0600
References: <20081229164032.GA8215@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Tony Li <tony.li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 29, 2008, at 10:40 AM, Anton Vorontsov wrote:

> This patch fixes following sparse warnings:
>
>  CHECK   fsl_pci.c
> fsl_pci.c:32:13: warning: symbol 'setup_pci_atmu' was not declared.  
> Should it be static?
> fsl_pci.c:89:13: warning: symbol 'setup_pci_cmd' was not declared.  
> Should it be static?
> fsl_pci.c:133:12: warning: symbol 'fsl_pcie_check_link' was not  
> declared. Should it be static?
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |    7 ++++---
> 1 files changed, 4 insertions(+), 3 deletions(-)

applied to next

- k
