Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B90F61A0079
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 20:40:09 +1100 (AEDT)
In-Reply-To: <1426999379-20542-2-git-send-email-shreyas@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,
 2/3] powerpc/powernv: Move cpuidle related code from setup.c to new
 file
Message-Id: <20150330094009.A575514015A@ozlabs.org>
Date: Mon, 30 Mar 2015 20:40:08 +1100 (AEDT)
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-22-03 at 04:42:58 UTC, "Shreyas B. Prabhu" wrote:
> This is a cleanup patch; doesn't change any functionality. Moves
> all cpuidle related code from setup.c to a new file.
> 
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
> This patch is new in v3
> 
>  arch/powerpc/platforms/powernv/Makefile |   2 +-
>  arch/powerpc/platforms/powernv/idle.c   | 186 ++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/setup.c  | 166 ----------------------------

Sorry this no longer applies, because I merged some changes from Preeti to
__init pnv_init_idle_states().

Can you please rebase on top of linux-next, or my next.

cheers
