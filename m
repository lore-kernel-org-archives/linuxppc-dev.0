Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1491C1A0A01
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 21:21:50 +1000 (AEST)
Message-ID: <1429010508.27414.1.camel@ellerman.id.au>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ingo Molnar <mingo@kernel.org>
Date: Tue, 14 Apr 2015 21:21:48 +1000
In-Reply-To: <20150414085541.GA30202@gmail.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
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

On Tue, 2015-04-14 at 10:55 +0200, Ingo Molnar wrote:
> * Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> wrote:
> 
> > This is another attempt to resurrect Andi Kleen's patchset so users
> > can specify perf events by their event names rather than raw codes.
> > 
> > This is a rebase of Andi Kleen's patchset from Jul 30, 2014[1] to 4.0.
> > (I fixed minor and not so minor conflicts).
> 
> So this series shows some progress, but instead of this limited 
> checkout ability I'd still prefer it if 'perf download' downloaded the 
> latest perf code itself and built it - it shouldn't be limited to just 
> a small subset of the perf source code!

Ingo, can you please stop blocking this? It's getting ridiculous.

We've been waiting over 8 months for this to go in.

While we've been waiting most of our users have learnt to use operf instead,
which doesn't require raw codes.

I would also add that exactly zero users have asked for a feature where perf
downloads and rebuilds itself. In fact many of them would consider that a
security breach.

cheers
