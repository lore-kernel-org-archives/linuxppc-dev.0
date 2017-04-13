Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3QZG1ZQ0zDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 13:02:30 +1000 (AEST)
Date: Thu, 13 Apr 2017 12:02:17 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] powerpc: a few kprobe fixes and refactoring
Message-Id: <20170413120217.0a1223bdaea42448ec011c66@kernel.org>
In-Reply-To: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
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

Hi Naveen,

BTW, I saw you sent 3 different series, are there any
conflict each other? or can we pick those independently?

Thanks,

On Wed, 12 Apr 2017 16:28:23 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> v1:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1334843.html
> 
> For v2, this series has been re-ordered and rebased on top of
> powerpc/next so as to make it easier to resolve conflicts with -tip. No
> other changes.
> 
> - Naveen
> 
> 
> Naveen N. Rao (5):
>   kprobes: convert kprobe_lookup_name() to a function
>   powerpc: kprobes: fix handling of function offsets on ABIv2
>   powerpc: introduce a new helper to obtain function entry points
>   powerpc: kprobes: factor out code to emulate instruction into a helper
>   powerpc: kprobes: emulate instructions on kprobe handler re-entry
> 
>  arch/powerpc/include/asm/code-patching.h |  37 ++++++++++
>  arch/powerpc/include/asm/kprobes.h       |  53 --------------
>  arch/powerpc/kernel/kprobes.c            | 119 +++++++++++++++++++++++++------
>  arch/powerpc/kernel/optprobes.c          |   6 +-
>  include/linux/kprobes.h                  |   1 +
>  kernel/kprobes.c                         |  21 +++---
>  6 files changed, 147 insertions(+), 90 deletions(-)
> 
> -- 
> 2.12.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
