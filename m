Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Bharat Bhushan <r65777@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: remove unnecessary line continuations
In-reply-to: <1372918546-15075-2-git-send-email-Bharat.Bhushan@freescale.com>
References: <1372918546-15075-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1372918546-15075-2-git-send-email-Bharat.Bhushan@freescale.com>
Date: Wed, 10 Jul 2013 17:25:01 +1000
Message-ID: <21869.1373441101@ale.ozlabs.ibm.com>
Cc: linux-kernel@vger.kernel.org, agraf@suse.de,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bharat Bhushan <r65777@freescale.com> wrote:

> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>

Acked-by: Michael Neuling <mikey@neuling.org>


> ---
>  arch/powerpc/kernel/process.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index c517dbe..19b8733 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -325,7 +325,7 @@ static void set_debug_reg_defaults(struct thread_struct *thread)
>  	/*
>  	 * Force User/Supervisor bits to b11 (user-only MSR[PR]=1)
>  	 */
> -	thread->dbcr1 = DBCR1_IAC1US | DBCR1_IAC2US |	\
> +	thread->dbcr1 = DBCR1_IAC1US | DBCR1_IAC2US |
>  			DBCR1_IAC3US | DBCR1_IAC4US;
>  	/*
>  	 * Force Data Address Compare User/Supervisor bits to be User-only
> -- 
> 1.7.0.4
> 
> 
