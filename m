Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26C22B7C0F
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2009 17:07:38 +1100 (EST)
Subject: Re: [GIT PULL] perf_event/tracing/powerpc patches from Anton Blanchard
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20091029065501.GB12874@elte.hu>
References: <19176.59441.523075.445864@drongo.ozlabs.ibm.com>
	<20091029065501.GB12874@elte.hu>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Oct 2009 17:04:09 +1100
Message-ID: <1256882649.6372.65.camel@pasglop>
Mime-Version: 1.0
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

On Thu, 2009-10-29 at 07:55 +0100, Ingo Molnar wrote:
> * Paul Mackerras <paulus@samba.org> wrote:
> 
> > Here is a series of patches from Anton Blanchard that implement some 
> > nice tracing and perf_event features on powerpc.  One of them is 
> > generic perf_event stuff (adding software events for alignment faults 
> > and instruction emulation faults).
> > 
> > Since this touches the perf_event and tracing subsystems as well as 
> > the powerpc architecture code, I think the best way forward is for 
> > both Ingo and Ben to pull it into their trees.  I have based it on the 
> > most recent point in Linus' tree that Ingo had pulled into his perf 
> > branches (as of yesterday or so).
> 
> The generic perf bits look good to me - can pull it if Ben OKs the 
> PowerPC bits.

Yup. Just went through all of them, they look fine. I also test built on
a number of default configs and it seems to pass.

Cheers,
Ben.
