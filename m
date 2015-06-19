Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC2871A0F31
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 14:19:43 +1000 (AEST)
Message-ID: <1434687583.23771.5.camel@ellerman.id.au>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Long <dave.long@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>,
 Anton Blanchard <anton@samba.org>, Behan Webster
 <behanw@converseincode.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke
 <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg
 Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo
 <rkuo@codeaurora.org>,  Robert Richter <rric@kernel.org>, Roland McGrath
 <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo
 <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon
 <will.deacon@arm.com>,  linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org,  linux-sh@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org,  x86@kernel.org
Date: Fri, 19 Jun 2015 14:19:43 +1000
In-Reply-To: <1434386579-6045-2-git-send-email-dave.long@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-15 at 12:42 -0400, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>  feature and has identical definitions in four different arch ptrace.h
> include files. It seems unlikely that definition would ever need to be
> changed regardless of architecture so lets move it into
> include/linux/ptrace.h.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 5 -----

Built and booted on powerpc, but is there an easy way to actually test the code
paths in question?

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
