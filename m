Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thxdZ1lK8zDwKn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 21:16:01 +1100 (AEDT)
Date: Mon, 19 Dec 2016 11:15:55 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc: Michael Ellerman <mpe@ellerman.id.au>, Jessica Yu <jeyu@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH] powerpc/livepatch: Remove klp_write_module_reloc()
 stub
In-Reply-To: <1481868864-27283-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Message-ID: <alpine.LSU.2.20.1612191115470.19203@cbobk.fhfr.pm>
References: <1481868864-27283-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Dec 2016, Kamalesh Babulal wrote:

> commit 425595a7fc20 ("livepatch: reuse module loader code
> to write relocations") offloads livepatch module relocation
> write to arch specific module loader code.
> 
> Remove unused klp_write_module_reloc() function stub.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/livepatch.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
> index a402f7f..47a03b9 100644
> --- a/arch/powerpc/include/asm/livepatch.h
> +++ b/arch/powerpc/include/asm/livepatch.h
> @@ -28,13 +28,6 @@ static inline int klp_check_compiler_support(void)
>  	return 0;
>  }
>  
> -static inline int klp_write_module_reloc(struct module *mod, unsigned long
> -		type, unsigned long loc, unsigned long value)
> -{
> -	/* This requires infrastructure changes; we need the loadinfos. */
> -	return -ENOSYS;
> -}
> -
>  static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
>  {
>  	regs->nip = ip;

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
