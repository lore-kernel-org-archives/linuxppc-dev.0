Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com
 [IPv6:2a00:1450:400c:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B57D31A0A01
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 22:58:30 +1000 (AEST)
Received: by wgso17 with SMTP id o17so10983962wgs.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 05:58:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 14 Apr 2015 14:58:22 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
Message-ID: <20150414125822.GA32761@gmail.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
 <1429010508.27414.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429010508.27414.1.camel@ellerman.id.au>
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


* Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Tue, 2015-04-14 at 10:55 +0200, Ingo Molnar wrote:
> > * Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> wrote:
> > 
> > > This is another attempt to resurrect Andi Kleen's patchset so users
> > > can specify perf events by their event names rather than raw codes.
> > > 
> > > This is a rebase of Andi Kleen's patchset from Jul 30, 2014[1] to 4.0.
> > > (I fixed minor and not so minor conflicts).
> > 
> > So this series shows some progress, but instead of this limited 
> > checkout ability I'd still prefer it if 'perf download' downloaded 
> > the latest perf code itself and built it - it shouldn't be limited 
> > to just a small subset of the perf source code!
> 
> Ingo, can you please stop blocking this? It's getting ridiculous.
> 
> We've been waiting over 8 months for this to go in.

We just merged a patch series that was first sent in 2013. Some things 
take time to get right.

> While we've been waiting most of our users have learnt to use operf 
> instead, which doesn't require raw codes.
> 
> I would also add that exactly zero users have asked for a feature 
> where perf downloads and rebuilds itself. In fact many of them would 
> consider that a security breach.

Fetching tracing scripts, plugins or other instrumentation scripts can 
be considered a 'security breach' as well. Fetching external tables 
(or network access to begin with) can be considered a 'security 
breach' as well, depending on how restricted an environment is.

But we don't design our code based on the most restrictive 
environments that are hostile to open source concepts!

Unfortunate users that are not allowed to update open source code that 
they are using should probably not update it. The other 99.9% of perf 
users would benefit from a properly done upgrading/updating feature.

Please stop thinking in terms of restricted, closed environments. 
Packaged perf will still work fine for them, and changes will still 
trickle down to them.

Thanks,

	Ingo
