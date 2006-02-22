Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31A3F679A6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Feb 2006 16:52:31 +1100 (EST)
Date: Tue, 21 Feb 2006 23:43:02 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: KRONSTORFER Horst <Horst.KRONSTORFER@frequentis.com>
Subject: Re: [PATCH] Fix BCSR_SIZE for MPC834xSYS
In-Reply-To: <C5BA91F04186584EB68FD42BB4993E6B5615B5@FRQWOLEX01.frequentis.frq>
Message-ID: <Pine.LNX.4.44.0602212342300.2878-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> hi!
> 
> according to the 'MPC8349E MDS Processor Board User Manual Rev. 1.6 12/2005'
> (table 3-1, p. 28) the size of the BCSR mapping is 32kb.
> 
> Signed-off-by: Horst Kronstorfer <hkronsto@frequentis.com>
> 
>  arch/ppc/platforms/83xx/mpc834x_sys.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h
> b/arch/ppc/platforms/83xx/mpc
> 834x_sys.h
> index aa86c22..6727bbd 100644
> --- a/arch/ppc/platforms/83xx/mpc834x_sys.h
> +++ b/arch/ppc/platforms/83xx/mpc834x_sys.h
> @@ -23,7 +23,7 @@
>  #define VIRT_IMMRBAR           ((uint)0xfe000000)
>  
>  #define BCSR_PHYS_ADDR         ((uint)0xf8000000)
> -#define BCSR_SIZE              ((uint)(128 * 1024))
> +#define BCSR_SIZE              ((uint)(32 * 1024))
>  
>  #define BCSR_MISC_REG2_OFF     0x07
>  #define BCSR_MISC_REG2_PORESET 0x01


In the future please provide patches that apply properly.  The issue is 
your mailer is reformatting the patch.

- kumar
