Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA9E9DE0CB
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 23:30:50 +1100 (EST)
Message-Id: <93F3BED3-0500-4F7C-8148-820F15067F75@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jrigby@freescale.com>
In-Reply-To: <1223406020-12278-4-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 3/3] powerpc: pci: 5121: Hide pci bridge.
Date: Wed, 8 Oct 2008 07:30:19 -0500
References: <1223406020-12278-1-git-send-email-jrigby@freescale.com>
	<1223406020-12278-2-git-send-email-jrigby@freescale.com>
	<1223406020-12278-3-git-send-email-jrigby@freescale.com>
	<1223406020-12278-4-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 7, 2008, at 2:00 PM, John Rigby wrote:

> The class of the MPC5121 pci host bridge is PCI_CLASS_BRIDGE_OTHER
> while other freescale host bridges have class set to
> PCI_CLASS_PROCESSOR_POWERPC.
>
> This patch makes fixup_hide_host_resource_fsl match
> PCI_CLASS_BRIDGE_OTHER in addition to PCI_CLASS_PROCESSOR_POWERPC.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
> arch/powerpc/kernel/pci_32.c |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)

applied

- k
