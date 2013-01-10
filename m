Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A8D8E2C00F3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 10:00:57 +1100 (EST)
Message-ID: <1357858846.4838.92.camel@pasglop>
Subject: Re: [PATCH] PowerPC documentation: fixed path to the powerpc directory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Waldecker <thomas.waldecker@gmail.com>
Date: Fri, 11 Jan 2013 10:00:46 +1100
In-Reply-To: <1357819632-30814-1-git-send-email-thomas.waldecker@gmail.com>
References: <1357819632-30814-1-git-send-email-thomas.waldecker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, rob@landley.net, linux-doc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-10 at 13:07 +0100, Thomas Waldecker wrote:
> ppc -> powerpc

I think I already applied something like that in powerpc -next, can you
dbl check ?

Cheers,
Ben.

> Signed-off-by: Thomas Waldecker <thomas.waldecker@gmail.com>
> ---
>  Documentation/powerpc/cpu_features.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/powerpc/cpu_features.txt b/Documentation/powerpc/cpu_features.txt
> index ffa4183..ae09df8 100644
> --- a/Documentation/powerpc/cpu_features.txt
> +++ b/Documentation/powerpc/cpu_features.txt
> @@ -11,10 +11,10 @@ split instruction and data caches, and if the CPU supports the DOZE and NAP
>  sleep modes.
>  
>  Detection of the feature set is simple. A list of processors can be found in
> -arch/ppc/kernel/cputable.c. The PVR register is masked and compared with each
> -value in the list. If a match is found, the cpu_features of cur_cpu_spec is
> -assigned to the feature bitmask for this processor and a __setup_cpu function
> -is called.
> +arch/powerpc/kernel/cputable.c. The PVR register is masked and compared with
> +each value in the list. If a match is found, the cpu_features of cur_cpu_spec
> +is assigned to the feature bitmask for this processor and a __setup_cpu
> +function is called.
>  
>  C code may test 'cur_cpu_spec[smp_processor_id()]->cpu_features' for a
>  particular feature bit. This is done in quite a few places, for example
> @@ -51,6 +51,6 @@ should be used in the majority of cases.
>  
>  The END_FTR_SECTION macros are implemented by storing information about this
>  code in the '__ftr_fixup' ELF section. When do_cpu_ftr_fixups
> -(arch/ppc/kernel/misc.S) is invoked, it will iterate over the records in
> +(arch/powerpc/kernel/misc.S) is invoked, it will iterate over the records in
>  __ftr_fixup, and if the required feature is not present it will loop writing
>  nop's from each BEGIN_FTR_SECTION to END_FTR_SECTION.
