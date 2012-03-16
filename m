Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1ECB9B6FEF
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 02:24:34 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q2GFORYO003819
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2012 10:24:29 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1257)
Subject: Re: [PATCH 1/2] powerpc/fsl-booke: Fixup calc_cam_sz to support MMU v2
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326915580-19652-1-git-send-email-galak@kernel.crashing.org>
Date: Fri, 16 Mar 2012 10:15:32 -0500
Message-Id: <68A50F51-3488-44A2-A26B-70CE7B7BCE28@kernel.crashing.org>
References: <1326915580-19652-1-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 18, 2012, at 1:39 PM, Kumar Gala wrote:

> The registers that describe size supported by TLB are different on MMU
> v2 as well as we support power of two page sizes.  For now we continue
> to assume that FSL variable size array supports all page sizes up to the
> maximum one reported in TLB1PS.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/reg_booke.h |    1 +
> arch/powerpc/mm/fsl_booke_mmu.c      |   19 +++++++++++++------
> 2 files changed, 14 insertions(+), 6 deletions(-)

applied

- k
