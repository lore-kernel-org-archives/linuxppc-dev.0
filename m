Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3F4f1Q7pzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 17:53:38 +1000 (AEST)
Message-ID: <1462780410.32643.1.camel@ellerman.id.au>
Subject: Re: perf tools: add support for generating bpf prologue on powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Arnaldo
 Carvalho de Melo
 <acme@redhat.com>, Wang Nan <wangnan0@huawei.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ian Munsie <imunsie@au1.ibm.com>
Date: Mon, 09 May 2016 17:53:30 +1000
In-Reply-To: <20160507111347.GP7880@naverao1-tp.in.ibm.com>
References: <1462461799-17518-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <3r1wL02fWFz9t3k@ozlabs.org> <20160507111347.GP7880@naverao1-tp.in.ibm.com>
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

On Sat, 2016-05-07 at 16:43 +0530, Naveen N. Rao wrote:
> On 2016/05/07 02:15PM, Michael Ellerman wrote:
> > On Thu, 2016-05-05 at 15:23:19 UTC, "Naveen N. Rao" wrote:
> > > Generalize existing macros to serve the purpose.
> > > 
> > > Cc: Wang Nan <wangnan0@huawei.com>
> > > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Ian Munsie <imunsie@au1.ibm.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > ---
> > > With this patch:
> > >     # ./perf test 37
> > >     37: Test BPF filter                                          :
> > >     37.1: Test basic BPF filtering                               : Ok
> > >     37.2: Test BPF prologue generation                           : Ok
> > >     37.3: Test BPF relocation checker                            : Ok
> > > 
> > >  tools/perf/arch/powerpc/Makefile          |  1 +
> > >  tools/perf/arch/powerpc/util/dwarf-regs.c | 40 +++++++++++++++++++++----------
> > >  2 files changed, 29 insertions(+), 12 deletions(-)
> > 
> > Looks feasible, and is in powerpc only code, should I take this or acme?
> 
> Hi Michael,
> Arnaldo has already pulled this in:
> http://article.gmane.org/gmane.linux.kernel/2216051

Ah sorry.

> It would be good if you can consider user stackdump as that depends on 
> perf regs support which you have added to powerpc-next:
> http://thread.gmane.org/gmane.linux.kernel/2210299/focus=2210749

Yep I did, it's in next.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=826dccfd238c3eeac379f5f637e5a3ddc7a4bc22

cheers
