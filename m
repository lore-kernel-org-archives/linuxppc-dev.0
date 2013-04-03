Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 726B62C0122
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 06:08:41 +1100 (EST)
Subject: Re: [PATCH] powerpc/pci: fix 64 bit pci size issue
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1364562377-7579-1-git-send-email-tie-fei.zang@freescale.com>
Date: Wed, 3 Apr 2013 14:08:35 -0500
Message-Id: <233D3FE1-2087-420B-A6F6-E3538F7560DF@kernel.crashing.org>
References: <1364562377-7579-1-git-send-email-tie-fei.zang@freescale.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 29, 2013, at 8:06 AM, Roy Zang wrote:

> The size might be 64 bit, so use ilog2() instead of __ilog2() or
> __ilog2_u64().
> 
> ilog2() can select 32bit or 64bit funciton automatically.
> 
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |   10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

applied to next

- k
