Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 35F342C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 03:46:21 +1100 (EST)
Subject: Re: [PATCH 01/17] powerpc/85xx: fix a bug with the parameter of
 mpic_reset_core()
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
Date: Wed, 3 Apr 2013 11:46:14 -0500
Message-Id: <02957AC2-0D69-4C17-A531-0FCAB403585F@kernel.crashing.org>
References: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 3, 2013, at 8:09 AM, Zhao Chenhui wrote:

> From: Chen-Hui Zhao <chenhui.zhao@freescale.com>
> 
> mpic_reset_core() need a logical cpu number instead of physical.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k
