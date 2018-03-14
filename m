Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGt3MRLzDr2V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:22 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-9-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [08/21] powerpc: Make function __giveup_fpu static
Message-Id: <401RGt0zpqz9sVn@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:23 UTC, Mathieu Malaterre wrote:
> When CONFIG_PPC_FPU is defined the prototype exposed in asm/switch_to.h is:
> 
>   extern void giveup_fpu(struct task_struct *);
> 
> Change the function prototype of __giveup_fpu to static. Fix warning
> (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/process.o
> arch/powerpc/kernel/process.c:176:6: error: no previous prototype for ‘__giveup_fpu’ [-Werror=missing-prototypes]
>  void __giveup_fpu(struct task_struct *tsk)
>       ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1cdf039bf82a39d816ca4b8161b01c

cheers
