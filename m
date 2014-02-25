Return-Path: <mattst88@gmail.com>
Received: from mail-qc0-x231.google.com (mail-qc0-x231.google.com
 [IPv6:2607:f8b0:400d:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6276E2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 04:40:39 +1100 (EST)
Received: by mail-qc0-f177.google.com with SMTP id m20so2632533qcx.22
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 09:40:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
References: <1391407232-4623-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-1-git-send-email-takahiro.akashi@linaro.org>
 <1393319784-2758-2-git-send-email-takahiro.akashi@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 25 Feb 2014 09:40:15 -0800
Message-ID: <CAEdQ38Hf=vEXEKhYaduR8HAcXyChQ-Wo7rHPGs20DirVwkDAxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] audit: Add CONFIG_HAVE_ARCH_AUDITSYSCALL
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linaro-kernel@lists.linaro.org,
 linux-ia64@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 linux-sh@vger.kernel.org, rgb@redhat.com, catalin.marinas@arm.com,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>, arndb@arndb.de,
 eparis@redhat.com, LKML <linux-kernel@vger.kernel.org>,
 linux-alpha <linux-alpha@vger.kernel.org>, dsaxena@linaro.org,
 Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-user@lists.sourceforge.net,
 linux-audit@redhat.com, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 25, 2014 at 1:16 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> Currently AUDITSYSCALL has a long list of architecture depencency:
>        depends on AUDIT && (X86 || PARISC || PPC || S390 || IA64 || UML ||
>                 SPARC64 || SUPERH || (ARM && AEABI && !OABI_COMPAT) || ALPHA)
> The purpose of this patch is to replace it with HAVE_ARCH_AUDITSYSCALL
> for simplicity.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/alpha/Kconfig     |    1 +
>  arch/arm/Kconfig       |    1 +
>  arch/ia64/Kconfig      |    1 +
>  arch/parisc/Kconfig    |    1 +
>  arch/powerpc/Kconfig   |    1 +
>  arch/s390/Kconfig      |    1 +
>  arch/sh/Kconfig        |    1 +
>  arch/sparc/Kconfig     |    1 +
>  arch/um/Kconfig.common |    1 +
>  arch/x86/Kconfig       |    1 +
>  init/Kconfig           |    5 ++++-
>  11 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index f6c6b34..b7ff9a3 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -22,6 +22,7 @@ config ALPHA
>         select GENERIC_SMP_IDLE_THREAD
>         select GENERIC_STRNCPY_FROM_USER
>         select GENERIC_STRNLEN_USER
> +       select HAVE_ARCH_AUDITSYSCALL
>         select HAVE_MOD_ARCH_SPECIFIC
>         select MODULES_USE_ELF_RELA
>         select ODD_RT_SIGACTION

Thanks.

Acked-by: Matt Turner <mattst88@gmail.com>
