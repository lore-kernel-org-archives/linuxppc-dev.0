Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2EF7FB858E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 14:14:11 +1000 (EST)
Subject: Re: [PATCH V2] fsl_booke: Correct test for MMU_FTR_BIG_PHYS
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1271089310-17607-1-git-send-email-beckyb@kernel.crashing.org>
Date: Mon, 19 Apr 2010 23:14:07 -0500
Message-Id: <C0DAF6AF-EE78-4935-8DD4-5BF651E0A3A7@kernel.crashing.org>
References: <1271089310-17607-1-git-send-email-beckyb@kernel.crashing.org>
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


On Apr 12, 2010, at 11:21 AM, Becky Bruce wrote:

> The code was looking for this in cpu_features, not mmu_features.  Fix this.
> 
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
> Switched to mmu_has_feature.....
> 
> arch/powerpc/mm/fsl_booke_mmu.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied to merge.

- k
