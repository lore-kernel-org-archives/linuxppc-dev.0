Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPqR91MNTzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 21:44:52 +1100 (AEDT)
Date: Fri, 17 Feb 2017 19:44:33 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Arnaldo Carvalho
 de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Ingo
 Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] powerpc: kretprobe updates
Message-Id: <20170217194433.0b4707bbfa1de603d13fbd30@kernel.org>
In-Reply-To: <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
References: <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 16 Feb 2017 13:47:37 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> I am posting the powerpc bits in the same thread so as to keep these
> changes together. I am not sure how this should be taken upstream as
> there are atleast three different trees involved: one for the core
> kprobes infrastructure, one for powerpc and one for perf.

Hmm, could you make these (and other related) patches and
other series in one series? Or wait for the other series
are merged correctly.

Thank you,

> 
> Thanks,
> Naveen
> 
> Naveen N. Rao (2):
>   powerpc: kretprobes: override default function entry offset
>   perf: powerpc: choose LEP with kretprobes
> 
>  arch/powerpc/kernel/kprobes.c               | 9 +++++++++
>  tools/perf/arch/powerpc/util/sym-handling.c | 5 +----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> -- 
> 2.11.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
