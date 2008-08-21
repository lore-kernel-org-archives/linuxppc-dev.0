Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5489DE0B4
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 05:58:22 +1000 (EST)
Message-Id: <19934E1D-A957-4987-9946-FE4BBB807625@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1219344622-13638-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] 85xx: fix build warning, remove silly cast
Date: Thu, 21 Aug 2008 14:58:12 -0500
References: <1219344622-13638-1-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2008, at 1:50 PM, Becky Bruce wrote:

> This fixes a build warning when PHYS_64BIT is enabled, and
> removes an unnecessary cast to phys_addr_t (the variable
> being cast is already a phys_addr_t)
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
> arch/powerpc/mm/fsl_booke_mmu.c |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)

applied to powerpc-next.

- k
