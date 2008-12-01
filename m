Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 340A3DDDDF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 05:15:49 +1100 (EST)
Date: Mon, 1 Dec 2008 13:15:47 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/5] powerpc: ftrace updates to previous patch series
In-Reply-To: <20081128131014.GC26793@elte.hu>
Message-ID: <alpine.DEB.1.10.0812011315020.7645@gandalf.stny.rr.com>
References: <20081126215821.263324391@goodmis.org>
	<alpine.DEB.1.10.0811261749310.1501@gandalf.stny.rr.com>
	<20081128131014.GC26793@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 28 Nov 2008, Ingo Molnar wrote:

> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 26 Nov 2008, Steven Rostedt wrote:
> > 
> > > Paul,
> > > 
> > > This patch series addresses the issues you brought up as well as
> > > adds some more enhancements and fixes. This series is added on
> > > top of the previous patch series.
> > > 
> > > The new patches are: (and are posted now)
> > > 5987225... powerpc/ppc32: static ftrace fixes for PPC32
> > 
> > The new commit id with the fix in Author and SoB is:
> > fd90db4bdc1ccf71927365cd634188cec4d7b151
> >  powerpc/ppc32: static ftrace fixes for 
> 
> Steve, you rebased the previous commits, and that's a no-no. I sorted it 
> all out, find below the stable URI for stuff that we'd like Paul to pull 
> shortly before the merge window.

Sorry, I rebased to edit the change log where I mispelled Paul's name.

-- Steve
