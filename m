Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2EF01A1767
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:22:58 +1100 (EST)
Message-ID: <1412659363.30859.146.camel@pasglop>
Subject: Re: [PATCH v2 2/5] powerpc: Adding macro for accessing Thread
 Switch Control Register
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Date: Tue, 07 Oct 2014 16:22:43 +1100
In-Reply-To: <1412149617-3178-3-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1412149617-3178-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1412149617-3178-3-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just fold that one in the patch that uses that register

On Wed, 2014-10-01 at 13:16 +0530, Shreyas B. Prabhu wrote:
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/reg.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 0c05059..cb65a73 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -371,6 +371,7 @@
>  #define SPRN_DBAT7L	0x23F	/* Data BAT 7 Lower Register */
>  #define SPRN_DBAT7U	0x23E	/* Data BAT 7 Upper Register */
>  #define SPRN_PPR	0x380	/* SMT Thread status Register */
> +#define SPRN_TSCR	0x399	/* Thread Switch Control Register */
>  
>  #define SPRN_DEC	0x016		/* Decrement Register */
>  #define SPRN_DER	0x095		/* Debug Enable Regsiter */
