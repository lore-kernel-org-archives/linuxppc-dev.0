Return-Path: <michael@ellerman.id.au>
Message-ID: <1339728629.29256.6.camel@concordia>
Subject: Re: [PATCH 1/2] powerpc/mm: remove obsolete comment about page size
 name array
From: Michael Ellerman <michael@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 15 Jun 2012 12:50:29 +1000
In-Reply-To: <20120614234055.GA17147@tyr.buserror.net>
References: <20120614234055.GA17147@tyr.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-14 at 18:40 -0500, Scott Wood wrote:
> The array of names in hugetlbpage.c no longer exists.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/include/asm/mmu.h |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index f014552..a9e9ec6 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -163,12 +163,7 @@ extern u64 ppc64_rma_size;
>   * to think about, feedback welcome. --BenH.
>   */
>  
> -/* There are #define as they have to be used in assembly
> - *
> - * WARNING: If you change this list, make sure to update the array of
> - * names currently in arch/powerpc/mm/hugetlbpage.c or bad things will
> - * happen
> - */
> +/* There are #define as they have to be used in assembly */
     ^^^^^^

Should be "These", I'll fix it up.

cheers
