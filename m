Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGZ4JcbzDqsV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:06 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-14-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [13/21] powerpc: Add missing prototype for arch_dup_task_struct
Message-Id: <401RGR2f60z9sD0@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:28 UTC, Mathieu Malaterre wrote:
> In commit 55ccf3fe3f9a ("fork: move the real prepare_to_copy() users to
> arch_dup_task_struct()") a new arch_dup_task_struct was added without a
> prototype declared in thread_info.h header. Fix the following warning
> (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/process.o
> arch/powerpc/kernel/process.c:1609:5: error: no previous prototype for ‘arch_dup_task_struct’ [-Werror=missing-prototypes]
>  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>      ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fd70d9f96d8182a67e28b99c999157

cheers
