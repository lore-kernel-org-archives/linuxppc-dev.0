Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 322901007D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:45:23 +1100 (EST)
Subject: Re: [PATCH] powerpc: fixup QE_General4 errata
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1314102605-9718-1-git-send-email-Joakim.Tjernlund@transmode.se>
Date: Thu, 24 Nov 2011 01:45:11 -0600
Message-Id: <ECF36C1E-4F5E-4208-B715-2A21DF6B00C0@kernel.crashing.org>
References: <1314102605-9718-1-git-send-email-Joakim.Tjernlund@transmode.se>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Aug 23, 2011, at 7:30 AM, Joakim Tjernlund wrote:

> QE_General4 should only round up the divisor iff divisor is > 3.
> Rounding up lower divisors makes the error too big, causing USB
> on MPC832x to fail.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
> arch/powerpc/sysdev/qe_lib/qe.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to merge

- k
