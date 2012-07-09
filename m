Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1DD852C01D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 00:27:29 +1000 (EST)
Subject: Re: [PATCH 2/3 v2] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag for
 FSL MPIC.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1341823595-15696-1-git-send-email-Varun.Sethi@freescale.com>
Date: Mon, 9 Jul 2012 09:27:33 -0500
Message-Id: <179D14E1-CF74-4502-80B7-FC44A28175D2@kernel.crashing.org>
References: <1341823595-15696-1-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2012, at 3:46 AM, Varun Sethi wrote:

> We should use the MPIC_LARG_VECTORS flag while intializing the MPIC. 
> This prevents us from eating in to hardware vector number space (MSIs)
> while setting up internal sources.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> arch/powerpc/sysdev/mpic.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

Can you remind me the issue here w/running into the MSIs?

- k
