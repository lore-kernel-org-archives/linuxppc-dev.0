Return-Path: <kim.phillips@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3st4Wl6js2zDsmq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 02:57:23 +1100 (AEDT)
Date: Mon, 10 Oct 2016 10:57:18 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <peterz@infradead.org>, <mingo@redhat.com>,
 <alexander.shishkin@linux.intel.com>, <treeze.taeung@gmail.com>,
 <naveen.n.rao@linux.vnet.ibm.com>, <markus@trippelsdorf.de>,
 <namhyung@kernel.org>, <pawel.moll@arm.com>, <chris.ryder@arm.com>,
 <jolsa@kernel.org>, <mhiramat@kernel.org>
Subject: Re: [PATCH v7 6/6] perf annotate: cross arch annotate support fixes
 for ARM
Message-Id: <20161010105718.a8a62e1e9c4327af4903436c@arm.com>
In-Reply-To: <57FB9BA8.2050506@linux.vnet.ibm.com>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1474472876-2706-7-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161005113406.GV7143@kernel.org>
 <57FB9BA8.2050506@linux.vnet.ibm.com>
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

On Mon, 10 Oct 2016 19:16:16 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> On Wednesday 05 October 2016 05:04 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Sep 21, 2016 at 09:17:56PM +0530, Ravi Bangoria escreveu:
> >> From: Kim Phillips <kim.phillips@arm.com>
> >>
> >> For ARM we remove the list that contains non-arm insns, and
> >> instead add more maintainable branch instruction regex logic.
> > This one looks ok and actually is in the direction of having facilities
> > for all arches, should've come as infrastructure that then gets used by
> > ARM and powerpc.
> 
> This was authored by Kim and I didn't wanted to change that so I kept it
> at the end.

I don't mind if this gets merged higher up in the series, in fact, I
think it's preferred to adding the arm insn table and then removing it
in the same series.  Keeping my Author: isn't necessary either:
something like "Signed-off-by: Kim Phillips <...> [ARM bits]" will
suffice.

> I'm sending a cleanup patch that applies on top of this series. That patch
> moves most of arch specific stuff from util/annotate.c to
> util/annotate/<arch>.c. Please review it.
> 
> Please pull this series if you are ok with that patch. Otherwise I'll respin
> entire series.

I'll wait for the dust to settle here before submitting an ARM return
insn fix, and aarch64 support originally authored by Chris Ryder
(basically translate table in [1] into regex format).

Thanks,

Kim

[1] https://lkml.org/lkml/2016/5/19/461
