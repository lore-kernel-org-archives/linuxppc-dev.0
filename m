Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E772FB6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 02:21:55 +1100 (EST)
Subject: Re: [RFC PATCH 01/16] powerpc/booke: Set CPU_FTR_DEBUG_LVL_EXC on
 32-bit
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111221013412.GA8378@schlenkerla.am.freescale.net>
Date: Mon, 9 Jan 2012 16:21:49 +0100
Message-Id: <C57ECE6B-1040-40BC-B7C7-5107533A2DC2@suse.de>
References: <20111221013412.GA8378@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 21.12.2011, at 02:34, Scott Wood wrote:

> Currently 32-bit only cares about this for choice of exception
> vector, which is done in core-specific code.  However, KVM will
> want to distinguish as well.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/include/asm/cputable.h |    5 +++--
> 1 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cputable.h =
b/arch/powerpc/include/asm/cputable.h
> index e30442c..033ad30 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -375,7 +375,8 @@ extern const char *powerpc_base_platform;
> #define CPU_FTRS_47X	(CPU_FTRS_440x6)
> #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
> 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
> -	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
> +	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE | \
> +	    CPU_FTR_DEBUG_LVL_EXC)

KVM on E200?


Alex
