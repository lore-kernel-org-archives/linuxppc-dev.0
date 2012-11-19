Return-Path: <BATV+8b051edebc15c1e831e6+3375+infradead.org+acme@canuck.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 67F7A2C00F8
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2012 02:07:59 +1100 (EST)
Date: Mon, 19 Nov 2012 12:07:33 -0300
From: Arnaldo Carvalho de Melo <acme@infradead.org>
To: Josh Boyer <jwboyer@gmail.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 31/32] perf powerpc: Use uapi/unistd.h to fix build error
Message-ID: <20121119150733.GD13607@infradead.org>
References: <1353248997-30763-1-git-send-email-acme@infradead.org>
 <1353248997-30763-32-git-send-email-acme@infradead.org>
 <CA+5PVA6uj3f5f9Gp=7Zp8CE+0mP7zgCknqmkUX_ootzDxUXRcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+5PVA6uj3f5f9Gp=7Zp8CE+0mP7zgCknqmkUX_ootzDxUXRcA@mail.gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Robert Richter <robert.richter@amd.com>, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Nov 19, 2012 at 08:29:09AM -0500, Josh Boyer escreveu:
> On Sun, Nov 18, 2012 at 9:29 AM, Arnaldo Carvalho de Melo <acme@infradead.org> wrote:
> > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

> > Use the 'unistd.h' from arch/powerpc/include/uapi to build the perf tool.
> 
> This would work for powerpc, but at least s390x and ARM have the same
> build issue.  Why would we fix this piecemeal per-arch?
> 
> David Howells has a patch that _should_ fix it for all of them at once.
> Is there a reason that isn't going in?

David rebased his patch on top of my perf/core branch, I just tested it
and all works as expected, so I'd say he should push that branch
upstream as I can't just cherry pick some csets, it needs a merge that
involves more than just tools/perf AFAIK.

- Arnaldo
