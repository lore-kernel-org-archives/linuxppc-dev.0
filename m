Return-Path: <ak@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 44F891A0143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 06:16:45 +1000 (AEST)
Date: Tue, 14 Apr 2015 13:16:43 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
Message-ID: <20150414201643.GY15335@tassilo.jf.intel.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150414085541.GA30202@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, peterz@infradead.org,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
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

On Tue, Apr 14, 2015 at 10:55:41AM +0200, Ingo Molnar wrote:
> 
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

I'm not against that idea (and can see it being useful in some cases[1]), 
but this would need some authentication. 

Otherwise it would be a "$bigbrother/nsa/anyone controling your network
can run everything on your computer" style hole.

The original JSON files don't have this problem because they didn't contain
any code.

-Andi

[1] especially to work around the broken perf setup on d./u. distros.
