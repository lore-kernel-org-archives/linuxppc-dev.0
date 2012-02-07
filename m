Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 87667B6F9F
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2012 05:21:55 +1100 (EST)
Date: Tue, 7 Feb 2012 12:21:43 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add PAMUBYPENR register definition to
 fsl_guts.h
In-Reply-To: <1328555872-9616-1-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.1202071221150.22169@gate.crashing.org>
References: <1328555872-9616-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Mon, 6 Feb 2012, Timur Tabi wrote:

> Add a defintion of register PAMUBYPENR (offset 0x604) to the global
> utilities structure.
>
> PAMUBYPENR is the PAMU bypass enable register.  It contains control
> bits for enabling bypass mode on each PAMU.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/include/asm/fsl_guts.h |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>

What code will use this?  Once such code exists, have this patch in that
patch series.

- k
