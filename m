Return-Path: <michael@ozlabs.org>
In-Reply-To: <1381906617-11392-2-git-send-email-khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: RE: [V3 01/10] perf: New conditional branch filter criteria in branch
 stack sampling
Message-Id: <20131126060618.917ED2C00A9@ozlabs.org>
Date: Tue, 26 Nov 2013 17:06:18 +1100 (EST)
From: michael@ozlabs.org (mpe@ellerman.id.au)
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, eranian@google.com,
 michaele@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ideally your commit subject would contain a verb, preferably in the present
tense.

I think simply "perf: Add PERF_SAMPLE_BRANCH_COND" would be clearer.

On Wed, 2013-16-10 at 06:56:48 UTC, Anshuman Khandual wrote:
> POWER8 PMU based BHRB supports filtering for conditional branches.
> This patch introduces new branch filter PERF_SAMPLE_BRANCH_COND which
> will extend the existing perf ABI. Other architectures can provide
> this functionality with either HW filtering support (if present) or
> with SW filtering of instructions.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Reviewed-by: Stephane Eranian <eranian@google.com>
> ---
>  include/uapi/linux/perf_event.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 0b1df41..5da52b6 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -160,8 +160,9 @@ enum perf_branch_sample_type {
>  	PERF_SAMPLE_BRANCH_ABORT_TX	= 1U << 7, /* transaction aborts */
>  	PERF_SAMPLE_BRANCH_IN_TX	= 1U << 8, /* in transaction */
>  	PERF_SAMPLE_BRANCH_NO_TX	= 1U << 9, /* not in transaction */
> +	PERF_SAMPLE_BRANCH_COND		= 1U << 10, /* conditional branches */
>  
> -	PERF_SAMPLE_BRANCH_MAX		= 1U << 10, /* non-ABI */
> +	PERF_SAMPLE_BRANCH_MAX		= 1U << 11, /* non-ABI */
>  };

This no longer applies against Linus' tree, you'll need to rebase it.

cheers
