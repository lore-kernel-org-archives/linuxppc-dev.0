Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51C32DE57B
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 16:38:59 +1100 (EST)
Message-Id: <F453BB59-BD33-4621-96AB-D91F515D4AB7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <12021712751503-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v2] Made FSL Book-E PMC support more generic
Date: Tue, 5 Feb 2008 23:38:51 -0600
References: <12021712751503-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 4, 2008, at 6:27 PM, Andy Fleming wrote:

> Some of the more recent e300 cores have the same performance monitor
> implementation as the e500.  e300 isn't book-e, so the name isn't
> really appropriate.  In preparation for e300 support, rename a bunch
> of fsl_booke things to say fsl_emb (Freescale Embedded Performance  
> Monitors).
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/kernel/cputable.c                     |    4 +-
> arch/powerpc/kernel/pmc.c                          |    2 +-
> arch/powerpc/oprofile/Makefile                     |    2 +-
> arch/powerpc/oprofile/common.c                     |    6 +-
> .../{op_model_fsl_booke.c => op_model_fsl_emb.c}   |   28 ++++----
> arch/powerpc/platforms/Kconfig.cputype             |    4 +
> include/asm-powerpc/cputable.h                     |    2 +-
> include/asm-powerpc/oprofile_impl.h                |    2 +-
> include/asm-powerpc/reg.h                          |    4 +
> include/asm-powerpc/reg_booke.h                    |   62  
> -----------------
> include/asm-powerpc/reg_fsl_emb.h                  |   72 +++++++++++ 
> +++++++++
> 11 files changed, 102 insertions(+), 86 deletions(-)
> rename arch/powerpc/oprofile/{op_model_fsl_booke.c =>  
> op_model_fsl_emb.c} (91%)
> create mode 100644 include/asm-powerpc/reg_fsl_emb.h


applied.

- k
