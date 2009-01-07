Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 441EADE4B3
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 15:27:08 +1100 (EST)
Message-Id: <1FC59878-C803-447A-9F2C-A18F3C858F92@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1231283543-26752-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: add Ethernet UPSMR definitions to QE library
Date: Tue, 6 Jan 2009 22:25:00 -0600
References: <1231283543-26752-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 6, 2009, at 5:12 PM, Timur Tabi wrote:

> Add the UCC_GETH_UPSMR_xxx definitions to qe.h.  The ucc_geth driver  
> will
> eventually use these instead of the UPSMR_ macros it currently  
> defines.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/include/asm/qe.h |   19 ++++++++++++++++++-
> 1 files changed, 18 insertions(+), 1 deletions(-)

applied

- k
