Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCbBy4ydbzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 07:58:02 +1000 (AEST)
Date: Mon, 23 May 2016 07:52:20 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: trivial@kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 anton@samba.org, cyrilbur@gmail.com, mikey@neuling.org,
 khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0226/1529] Fix typo
Message-ID: <20160522215220.GA26398@fergus.ozlabs.ibm.com>
References: <20160521120600.11742-1-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160521120600.11742-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 21, 2016 at 02:06:00PM +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/powerpc/kernel/process.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index e2f12cb..6d39786 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -709,7 +709,7 @@ static inline int set_dawr(struct arch_hw_breakpoint *brk)
>  	dawrx |= (brk->type & (HW_BRK_TYPE_PRIV_ALL)) \
>  		                   >> 3; //* PRIM bits */
>  	/* dawr length is stored in field MDR bits 48:53.  Matches range in
> -	   doublewords (64 bits) baised by -1 eg. 0b000000=1DW and
> +	   doublewords (64 bits) raised by -1 eg. 0b000000=1DW and

biased
