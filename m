Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ1y14MjBzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 06:06:32 +1100 (AEDT)
Date: Thu, 2 Mar 2017 16:06:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 4/5] perf: kretprobes: offset from reloc_sym if kernel
 supports it
Message-ID: <20170302190625.GB12788@kernel.org>
References: <20170224201103.GO3595@kernel.org>
 <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Mar 02, 2017 at 11:25:04PM +0530, Naveen N. Rao escreveu:
> On 2017/02/24 05:11PM, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Feb 25, 2017 at 02:29:17AM +0900, Masami Hiramatsu escreveu:
> > > On Fri, 24 Feb 2017 00:46:08 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > > Thanks. I hope that's an Ack for this patchset?
> > > 
> > > OK, for 1/5, 2/5, 3/5, and 5/5;
> > > 
> > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > And could you make v4 series including all patches? (Not only updates)
> > 
> > So, to make progress I processed these:
> > 
> > [acme@jouet linux]$ git log --oneline -3
> > eb55608340b7 perf probe: Generalize probe event file open routine
> > 859d718fac06 trace/kprobes: Allow return probes with offsets and absolute addresses
> > a10489121c81 kretprobes: Ensure probe location is at function entry
> > [acme@jouet linux]$
> > 
> > Waiting for Naveen to react to these last minute considerations from
> > Masami and for the Ack from the PPC guys about "[PATCH v2 2/5] powerpc:
> > kretprobes: override default function entry offset".
> 
> Arnaldo,
> I am posting the remaining three patches in this series. These three
> patches are on top of the above 3 patches you have processed and the
> other powerpc kretprobes patch (v2 2/5).
> 
> Masami,
> Kindly review and let me know if this is fine.

Will process after Masami-san has time to review it,

Thanks,

- Arnaldo
