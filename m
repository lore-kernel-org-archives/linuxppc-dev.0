Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EC2A1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 23:06:54 +1000 (AEST)
Date: Sat, 18 Apr 2015 15:05:36 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
Message-ID: <20150418130536.GA1514@krava.brq.redhat.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
 <1429010508.27414.1.camel@ellerman.id.au>
 <20150414125822.GA32761@gmail.com>
 <1429052004.10000.1.camel@ellerman.id.au>
 <20150415092557.GA14942@gmail.com>
 <20150415205042.GA11620@us.ibm.com> <20150417153126.GA17654@krava>
 <20150417200954.GA7056@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150417200954.GA7056@tassilo.jf.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, peterz@infradead.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Pekka Enberg <penberg@iki.fi>, Linus Torvalds <torvalds@linux-foundation.org>,
 mingo@redhat.com, Borislav Petkov <bp@alien8.de>, namhyung@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2015 at 01:09:54PM -0700, Andi Kleen wrote:
> On Fri, Apr 17, 2015 at 05:31:26PM +0200, Jiri Olsa wrote:
> > On Wed, Apr 15, 2015 at 01:50:42PM -0700, Sukadev Bhattiprolu wrote:
> > 
> > SNIP
> > 
> > > | 
> > > |  - to blindly follow some poorly constructed vendor format with no 
> > > |    high level structure, that IMHO didn't work very well when OProfile 
> > > |    was written, and misrepresenting it as 'symbolic event names'.
> > > | 
> > > |    Take a look at:
> > > | 
> > > |      https://download.01.org/perfmon/HSW/Haswell_core_V17.json
> > > | 
> > > |    and weep.
> > > 
> > > Evil vendor formats, but to be fair, here is what _we_ have today:
> > > 
> > > 	perf stat -e r10068,r20036,r40060,r40ac sleep 1
> > 
> > hum, you could also use the 'cpu/event=.../' syntax right?
> 
> That's even worse -- same hex numbers, just more redundancy.

no, it's far more readable then the rXXXX format,
you can just put in whatevent is in the spec..
event,umask,any etc and dont bother with making
rXXXX value

but I mentioned it just to give the whole picture,
I agree that we need the symbolic names support

jirka
