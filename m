Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 01C82B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2011 16:02:35 +1100 (EST)
Subject: Re: [PATCH v2] powerpc/fsl-booke: Fix settlbcam for 64-bit
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <13184542222469-git-send-email-beckyb@kernel.crashing.org>
Date: Thu, 13 Oct 2011 00:02:30 -0500
Message-Id: <4E855C1B-5E87-4692-9C83-289026BAE932@kernel.crashing.org>
References: <13184542222469-git-send-email-beckyb@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 12, 2011, at 4:17 PM, Becky Bruce wrote:

> From: Becky Bruce <beckyb@kernel.crashing.org>
> 
> Currently, it does a cntlzd on the size and then subtracts it from
> 21.... this doesn't take into account the varying size of a "long".
> Just use __ilog instead (and subtract the 10 we have to subtract
> to get to the tsize encoding).
> 
> Also correct the comment about page sizes supported.
> 
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
> Sent the wrong version last time; also noticed that the comment is
> incorrect now that we have 64-bit and added that to the patch.
> 
> arch/powerpc/mm/fsl_booke_mmu.c |   12 ++++++------
> 1 files changed, 6 insertions(+), 6 deletions(-)

applied

- k
