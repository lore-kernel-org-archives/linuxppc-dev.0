Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FA39474E0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 02:51:29 +1100 (EST)
Message-Id: <436FB7D3-D210-4D3F-9D1E-DC865C2A05DA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1228426487-7607-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Fix the ide suspend function in uli1575
Date: Tue, 6 Jan 2009 09:49:20 -0600
References: <1228426487-7607-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 4, 2008, at 3:34 PM, Kumar Gala wrote:

> From: Jason Jin <Jason.jin@freescale.com>
>
> The general pci resume code can only restore part of the
> configuration registers. We need to reconfigure those
> registers in the FIXUP_RESUME.
>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/platforms/fsl_uli1575.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied

- k
