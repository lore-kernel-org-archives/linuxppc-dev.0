Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EA51DEAE7
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 02:15:28 +1000 (EST)
Message-Id: <F12BABCD-D7AA-4A85-AF3B-8021A1FFBAF0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <1209751430-25656-1-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2.6.26] powerpc: Add support for multiple gfar mdio
	interfaces
Date: Tue, 15 Jul 2008 11:15:16 -0500
References: <1209751430-25656-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 1:03 PM, Andy Fleming wrote:

> The old code assumed there was only one, but the 8572 actually has 3.
>
> Also, our usual id, 0xe0024520, gets resolved to -1 somewhere, and  
> this was
> preventing the multiple buses from having different ids.  So we only  
> keep
> the low 20 bits, which have the interesting info, anyway.
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |   84 +++++++++++++++++ 
> +----------------------
> 1 files changed, 38 insertions(+), 46 deletions(-)

applied.

- k
