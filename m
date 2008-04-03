Return-Path: <galak@kernel.crashing.org>
Message-Id: <D2F6D36A-305A-4380-B2AE-1308D0147472@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Emil Medve <Emilian.Medve@Freescale.com>
In-Reply-To: <1207177533-30598-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Fix a mm compile error
Date: Thu, 3 Apr 2008 01:20:25 -0500
References: <1207177533-30598-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 2, 2008, at 6:05 PM, Emil Medve wrote:
> arch/powerpc/mm/init_32.c:102: error: conflicting types for  
> '__initial_memory_limit_addr'
> arch/powerpc/mm/mmu_decl.h:51: error: previous declaration of  
> '__initial_memory_limit_addr' was here
>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
> arch/powerpc/mm/init_32.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
> index 555bb7e..63c5e3d 100644
> --- a/arch/powerpc/mm/init_32.c
> +++ b/arch/powerpc/mm/init_32.c
> @@ -99,7 +99,7 @@ unsigned long __max_low_memory = MAX_LOW_MEM;
>  * address of the limit of what is accessible with initial MMU setup -
>  * 256MB usually, but only 16MB on 601.
>  */
> -unsigned long __initial_memory_limit_addr = 0x10000000;
> +phys_addr_t __initial_memory_limit_addr = 0x10000000;

I should have fixed this in my tree, if there are still issues let me  
know.

- k
