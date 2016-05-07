Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1wL03XS7zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2016 14:15:36 +1000 (AEST)
In-Reply-To: <1462461799-17518-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Wang Nan <wangnan0@huawei.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: perf tools: add support for generating bpf prologue on powerpc
Message-Id: <3r1wL02fWFz9t3k@ozlabs.org>
Date: Sat,  7 May 2016 14:15:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-05-05 at 15:23:19 UTC, "Naveen N. Rao" wrote:
> Generalize existing macros to serve the purpose.
> 
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> With this patch:
>     # ./perf test 37
>     37: Test BPF filter                                          :
>     37.1: Test basic BPF filtering                               : Ok
>     37.2: Test BPF prologue generation                           : Ok
>     37.3: Test BPF relocation checker                            : Ok
> 
>  tools/perf/arch/powerpc/Makefile          |  1 +
>  tools/perf/arch/powerpc/util/dwarf-regs.c | 40 +++++++++++++++++++++----------
>  2 files changed, 29 insertions(+), 12 deletions(-)

Looks feasible, and is in powerpc only code, should I take this or acme?

cheers
