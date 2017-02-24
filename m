Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVJ4v5LjDzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 04:29:34 +1100 (AEDT)
Date: Sat, 25 Feb 2017 02:29:17 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Ingo Molnar
 <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho
 de Melo <acme@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/5] perf: kretprobes: offset from reloc_sym if
 kernel supports it
Message-Id: <20170225022917.cfb45d0ea41c22fcb5d61ebb@kernel.org>
In-Reply-To: <20170223191608.GC4212@naverao1-tp.localdomain>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <75bafc91e9d381636f68ab9923ce3d52f9157a09.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170223181022.7d4427714cabbb7ccd6d6673@kernel.org>
 <20170223191608.GC4212@naverao1-tp.localdomain>
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

On Fri, 24 Feb 2017 00:46:08 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/02/23 06:10PM, Masami Hiramatsu wrote:
> > On Wed, 22 Feb 2017 19:23:40 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > We indicate support for accepting sym+offset with kretprobes through a
> > > line in ftrace README. Parse the same to identify support and choose the
> > > appropriate format for kprobe_events.
> > > 
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > ---
> > >  tools/perf/util/probe-event.c | 47 ++++++++++++++++++++++++++++++++++++-------
> > >  tools/perf/util/probe-event.h |  2 ++
> > >  2 files changed, 42 insertions(+), 7 deletions(-)
> > > 
> 
> [snip]
> 
> > 
> > Could you reuse (refactoring) probe_type_is_available() in probe-file.c to share
> > opening README file?
> 
> Done. I've sent patches to do that, please review.

OK.

> 
> > 
> > Others looks good to me :)
> 
> Thanks. I hope that's an Ack for this patchset?

OK, for 1/5, 2/5, 3/5, and 5/5;

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

And could you make v4 series including all patches? (Not only updates)

> 
> If so, and if Ingo/Michael agree, would it be ok to take the kernel bits 
> through the powerpc tree like we did for kprobe_exceptions_notify() 
> cleanup?

If it is not urgent (yes, it seems) and since it changes arch independent
parts, I think this series should finally go through Ingo's tree.


Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
