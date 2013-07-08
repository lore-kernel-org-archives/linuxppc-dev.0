Return-Path: <michael@ellerman.id.au>
Date: Mon, 8 Jul 2013 18:28:45 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc, perf: Add generic cache reference and cache
 miss events for POWER8 PMU
Message-ID: <20130708082844.GA18271@concordia>
References: <51D11DEF.8070302@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51D11DEF.8070302@linux.vnet.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <ellerman@au1.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 01, 2013 at 11:43:03AM +0530, Anshuman Khandual wrote:
> powerpc, perf: Add generic cache reference and cache miss events for POWER8 PMU
> 
> This enables generic cache reference and cache miss events on POWER8 systems by
> utilizing raw PMU event codes for L1 cache reference and L1 cache miss events
> respectively.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
> index f7d1c4f..5ccddac 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -24,6 +24,8 @@
>  #define PM_INST_CMPL			0x00002
>  #define PM_BRU_FIN			0x10068
>  #define PM_BR_MPRED_CMPL		0x400f6
> +#define PM_LD_MISS_L1			0x3E054
> +#define PM_LD_REF_L1			0x100EE

Hi Anshuman,

Which system did you test this on and what results did you see?

cheers
