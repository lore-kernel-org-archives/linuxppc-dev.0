Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r25d94cXSzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2016 21:14:21 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 7 May 2016 16:44:16 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 45692125804F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2016 16:46:20 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u47BEMs225624930
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 7 May 2016 16:44:22 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u47BECDS024569
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 7 May 2016 16:44:14 +0530
Date: Sat, 7 May 2016 16:43:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Wang Nan <wangnan0@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: perf tools: add support for generating bpf prologue on powerpc
Message-ID: <20160507111347.GP7880@naverao1-tp.in.ibm.com>
References: <1462461799-17518-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <3r1wL02fWFz9t3k@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3r1wL02fWFz9t3k@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/05/07 02:15PM, Michael Ellerman wrote:
> On Thu, 2016-05-05 at 15:23:19 UTC, "Naveen N. Rao" wrote:
> > Generalize existing macros to serve the purpose.
> > 
> > Cc: Wang Nan <wangnan0@huawei.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Ian Munsie <imunsie@au1.ibm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> > With this patch:
> >     # ./perf test 37
> >     37: Test BPF filter                                          :
> >     37.1: Test basic BPF filtering                               : Ok
> >     37.2: Test BPF prologue generation                           : Ok
> >     37.3: Test BPF relocation checker                            : Ok
> > 
> >  tools/perf/arch/powerpc/Makefile          |  1 +
> >  tools/perf/arch/powerpc/util/dwarf-regs.c | 40 +++++++++++++++++++++----------
> >  2 files changed, 29 insertions(+), 12 deletions(-)
> 
> Looks feasible, and is in powerpc only code, should I take this or acme?

Hi Michael,
Arnaldo has already pulled this in:
http://article.gmane.org/gmane.linux.kernel/2216051

It would be good if you can consider user stackdump as that depends on 
perf regs support which you have added to powerpc-next:
http://thread.gmane.org/gmane.linux.kernel/2210299/focus=2210749

Thanks,
Naveen
