Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 647B91A012A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 08:53:25 +1000 (AEST)
Message-ID: <1429052004.10000.1.camel@ellerman.id.au>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ingo Molnar <mingo@kernel.org>
Date: Wed, 15 Apr 2015 08:53:24 +1000
In-Reply-To: <20150414125822.GA32761@gmail.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
 <1429010508.27414.1.camel@ellerman.id.au>
 <20150414125822.GA32761@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, ak@linux.intel.com,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, peterz@infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
 namhyung@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 Pekka Enberg <penberg@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-14 at 14:58 +0200, Ingo Molnar wrote:
> * Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > On Tue, 2015-04-14 at 10:55 +0200, Ingo Molnar wrote:
> > > * Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> wrote:
> > > 
> > > > This is another attempt to resurrect Andi Kleen's patchset so users
> > > > can specify perf events by their event names rather than raw codes.
> > > > 
> > > > This is a rebase of Andi Kleen's patchset from Jul 30, 2014[1] to 4.0.
> > > > (I fixed minor and not so minor conflicts).
> > > 
> > > So this series shows some progress, but instead of this limited 
> > > checkout ability I'd still prefer it if 'perf download' downloaded 
> > > the latest perf code itself and built it - it shouldn't be limited 
> > > to just a small subset of the perf source code!
> > 
> > Ingo, can you please stop blocking this? It's getting ridiculous.
> > 
> > We've been waiting over 8 months for this to go in.
> 
> We just merged a patch series that was first sent in 2013. Some things 
> take time to get right.

The first attempt to get symbolic event name support into perf was sent in
2010, that's FIVE years ago [1].

And what complicated feature are we asking for? The ability to map a human
readable name to a hex code, it has the complexity of a first year programming
assignment.

Variations have been submitted by IBM [1], by Facebook [2], now by Intel, and
Google have just given up and carry the libpfm4 patch in their perf tool [3].

Can we please just get this merged.

If you *then* want to add support for perf auto-updating that's fine, but don't
conflate the two.
 
cheers


[1]: https://lkml.org/lkml/2010/3/11/146
[2]: http://article.gmane.org/gmane.comp.linux.perfmon2.devel/2912
[3]: https://github.com/David-Levinthal/gooda/blob/master/gooda-analyzer/perf-patches/linux-v3.17/0001-perf-tools-add-support-for-libpfm4.patch
