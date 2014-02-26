Return-Path: <mpe@ellerman.id.au>
Message-ID: <1393417896.17341.2.camel@concordia>
Subject: Re: [PATCH v2 1/1] audit: Add CONFIG_HAVE_ARCH_AUDITSYSCALL
From: Michael Ellerman <mpe@ellerman.id.au>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Wed, 26 Feb 2014 23:31:36 +1100
In-Reply-To: <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
References: <1391407232-4623-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-s390@vger.kernel.org, linaro-kernel@lists.linaro.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 rgb@redhat.com, catalin.marinas@arm.com, x86@kernel.org, will.deacon@arm.com,
 arndb@arndb.de, eparis@redhat.com, linux-kernel@vger.kernel.org,
 dsaxena@linaro.org, viro@zeniv.linux.org.uk,
 user-mode-linux-user@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-audit@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-02-25 at 18:16 +0900, AKASHI Takahiro wrote:
> Currently AUDITSYSCALL has a long list of architecture depencency:
>        depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML ||
> 		SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ALPHA)
> The purpose of this patch is to replace it with HAVE_ARCH_AUDITSYSCALL
> for simplicity.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 957bf34..7b3b8fe 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -141,6 +141,7 @@ config PPC
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select HAVE_IRQ_EXIT_ON_IRQ_STACK
>  	select ARCH_USE_CMPXCHG_LOCKREF if PPC64
> +	select HAVE_ARCH_AUDITSYSCALL
>  
>  config GENERIC_CSUM
>  	def_bool CPU_LITTLE_ENDIAN

Looks good for powerpc.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
