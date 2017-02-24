Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVMgK3rKTzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 07:11:09 +1100 (AEDT)
Date: Fri, 24 Feb 2017 17:11:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/5] perf: kretprobes: offset from reloc_sym if kernel
 supports it
Message-ID: <20170224201103.GO3595@kernel.org>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <75bafc91e9d381636f68ab9923ce3d52f9157a09.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170223181022.7d4427714cabbb7ccd6d6673@kernel.org>
 <20170223191608.GC4212@naverao1-tp.localdomain>
 <20170225022917.cfb45d0ea41c22fcb5d61ebb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170225022917.cfb45d0ea41c22fcb5d61ebb@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Sat, Feb 25, 2017 at 02:29:17AM +0900, Masami Hiramatsu escreveu:
> On Fri, 24 Feb 2017 00:46:08 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > Thanks. I hope that's an Ack for this patchset?
> 
> OK, for 1/5, 2/5, 3/5, and 5/5;
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> And could you make v4 series including all patches? (Not only updates)

So, to make progress I processed these:

[acme@jouet linux]$ git log --oneline -3
eb55608340b7 perf probe: Generalize probe event file open routine
859d718fac06 trace/kprobes: Allow return probes with offsets and absolute addresses
a10489121c81 kretprobes: Ensure probe location is at function entry
[acme@jouet linux]$

Waiting for Naveen to react to these last minute considerations from
Masami and for the Ack from the PPC guys about "[PATCH v2 2/5] powerpc:
kretprobes: override default function entry offset".

- Arnaldo
