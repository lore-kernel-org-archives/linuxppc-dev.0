Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86EFEB7088
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Nov 2009 20:35:31 +1100 (EST)
Date: Sun, 8 Nov 2009 10:35:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [GIT PULL] perf_event/tracing/powerpc patches from Anton Blanchard
Message-ID: <20091108093518.GD21267@elte.hu>
References: <19176.59441.523075.445864@drongo.ozlabs.ibm.com>
	<20091029065501.GB12874@elte.hu> <1256882649.6372.65.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1256882649.6372.65.camel@pasglop>
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2009-10-29 at 07:55 +0100, Ingo Molnar wrote:
> > * Paul Mackerras <paulus@samba.org> wrote:
> > 
> > > Here is a series of patches from Anton Blanchard that implement some 
> > > nice tracing and perf_event features on powerpc.  One of them is 
> > > generic perf_event stuff (adding software events for alignment faults 
> > > and instruction emulation faults).
> > > 
> > > Since this touches the perf_event and tracing subsystems as well as 
> > > the powerpc architecture code, I think the best way forward is for 
> > > both Ingo and Ben to pull it into their trees.  I have based it on the 
> > > most recent point in Linus' tree that Ingo had pulled into his perf 
> > > branches (as of yesterday or so).
> > 
> > The generic perf bits look good to me - can pull it if Ben OKs the 
> > PowerPC bits.
> 
> Yup. Just went through all of them, they look fine. I also test built on
> a number of default configs and it seems to pass.

Pulled into tip:perf/powerpc (will keep it in a separate branch for a 
few days then it can go into perf/core), thanks guys!

	Ingo
