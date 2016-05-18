Return-Path: <re.emese@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8r2m2sVnzDqCJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 20:26:24 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id g17so5058196wme.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 03:26:24 -0700 (PDT)
Date: Wed, 18 May 2016 12:33:27 +0200
From: Emese Revfy <re.emese@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linux-kbuild@vger.kernel.org, pageexec@freemail.hu, spender@grsecurity.net,
 mmarek@suse.com, keescook@chromium.org, linux@rasmusvillemoes.dk,
 fengguang.wu@intel.com, dvyukov@google.com, linux-kernel@vger.kernel.org,
 david.brown@linaro.org, yamada.masahiro@socionext.com, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [kernel-hardening] [PATCH v8 2/4] GCC plugin infrastructure
Message-Id: <20160518123327.9018f73af78a47b4456b2027@gmail.com>
In-Reply-To: <573C2CFE.8060305@au1.ibm.com>
References: <20160513015456.01415979f20a68eb7d2d9290@gmail.com>
 <20160513015725.30223ee16a2a3860b4392b90@gmail.com>
 <573C2CFE.8060305@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I've done some basic sanity testing on powerpc with the cyclomatic 
> complexity plugin (with LE native + cross-compilers) and it seems to 
> work with the patch below.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a18a0dc..0cfed5b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -97,6 +97,7 @@ config PPC
>          select HAVE_DYNAMIC_FTRACE_WITH_REGS if MPROFILE_KERNEL
>          select HAVE_FUNCTION_TRACER
>          select HAVE_FUNCTION_GRAPH_TRACER
> +       select HAVE_GCC_PLUGINS
>          select SYSCTL_EXCEPTION_TRACE
>          select ARCH_WANT_OPTIONAL_GPIOLIB
>          select VIRT_TO_BUS if !PPC64

Hi,

Did you test the plugins with all gcc versions (4.5-6)?

-- 
Emese
