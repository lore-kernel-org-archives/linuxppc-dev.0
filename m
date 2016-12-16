Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg4Zf3Q2zzDw5v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 20:22:02 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i88so4233944pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 01:22:02 -0800 (PST)
Subject: Re: [PATCH] powerpc/livepatch: Remove klp_write_module_reloc() stub
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jessica Yu <jeyu@redhat.com>
References: <1481868864-27283-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f946196f-3076-f0de-0843-3bd9f426a2ac@gmail.com>
Date: Fri, 16 Dec 2016 20:21:47 +1100
MIME-Version: 1.0
In-Reply-To: <1481868864-27283-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/12/16 17:14, Kamalesh Babulal wrote:
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

Makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>
