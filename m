Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BBC46DDF9C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 00:12:22 +1000 (EST)
Message-Id: <2FCD1DE6-1F9C-4B9B-9657-DABB5EB2A2F3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090502021647.GA18281@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/6] powerpc/85xx: Add PCI IDs for MPC8569 family
	processors
Date: Fri, 8 May 2009 09:10:12 -0500
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
	<20090502021647.GA18281@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 9:16 PM, Anton Vorontsov wrote:

> This patch adds PCI IDs for MPC8569 and MPC8569E processors,
> plus adds appropriate quirks for these IDs, and thus makes
> PCI-E actually work on MPC8569E-MDS boards.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |    2 ++
> include/linux/pci_ids.h       |    2 ++
> 2 files changed, 4 insertions(+), 0 deletions(-)

applied to next

- k
