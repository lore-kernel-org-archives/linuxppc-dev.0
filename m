Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EE4F12C008C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 00:21:23 +1100 (EST)
Subject: Re: [PATCH 2/4] iommu/fsl: Add PAMU bypass enable register to
 ccsr_guts structure.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1353419697-31269-3-git-send-email-Varun.Sethi@freescale.com>
Date: Sun, 25 Nov 2012 07:21:15 -0600
Message-Id: <44C37358-9372-42E1-830A-6F59B2403B31@kernel.crashing.org>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
 <1353419697-31269-3-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: joerg.roedel@amd.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 20, 2012, at 7:54 AM, Varun Sethi wrote:

> PAMU bypass enable register added to the ccsr_guts structure.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> arch/powerpc/include/asm/fsl_guts.h |    4 +++-
> 1 files changed, 3 insertions(+), 1 deletions(-)

applied to next

- k
