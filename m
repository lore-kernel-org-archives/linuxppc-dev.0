Return-Path: <michael@ozlabs.org>
In-Reply-To: <1392415338-16288-5-git-send-email-cody@linux.vnet.ibm.com>
To: Cody P Schafer <cody@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 04/11] powerpc: add hvcalls for 24x7 and gpci (get
 performance counter info)
Message-Id: <20140225033327.878F52C0256@ozlabs.org>
Date: Tue, 25 Feb 2014 14:33:27 +1100 (EST)
Cc: Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-14-02 at 22:02:08 UTC, Cody P Schafer wrote:
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hvcall.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index d8b600b..652f7e4 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -274,6 +274,11 @@
>  /* Platform specific hcalls, used by KVM */
>  #define H_RTAS			0xf000
>  
> +/* "Platform specific hcalls", provided by PHYP */
> +#define H_GET_24X7_CATALOG_PAGE 0xF078
> +#define H_GET_24X7_DATA		0xF07C
> +#define H_GET_PERF_COUNTER_INFO 0xF080

Some tabs some spaces, use tabs.

cheers
