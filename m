Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C88222C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 01:50:28 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: Update compilation flags with core specific
 options
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1374753254-10381-1-git-send-email-catalin.udma@freescale.com>
Date: Fri, 26 Jul 2013 10:50:23 -0500
Message-Id: <6CCCB1C2-FA50-476A-B3D0-9F8FCAC404E5@kernel.crashing.org>
References: <1374753254-10381-1-git-send-email-catalin.udma@freescale.com>
To: Catalin Udma <catalin.udma@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 25, 2013, at 6:54 AM, Catalin Udma wrote:

> If CONFIG_E500 is enabled, the compilation flags are updated
> specifying the target core -mcpu=e5500/e500mc/8540
> Also remove -Wa,-me500, being incompatible with -mcpu=e5500/e6500
> The assembler option is redundant if the -mcpu= flag is set.
> The patch fixes the kernel compilation problem for e5500/e6500
> when using gcc option -mcpu=e5500/e6500.
> 
> Signed-off-by: Catalin Udma <catalin.udma@freescale.com>
> ---
> changes for v2: 
>    - update also KBUILD_AFLAGS with -mcpu and -msoft-float flags
> 
> arch/powerpc/Makefile |   16 +++++++++++++++-
> 1 files changed, 15 insertions(+), 1 deletions(-)

Is the assembler redundant for older toolchains?

- k
