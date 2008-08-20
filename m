Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 7D3AEDE5D4
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 01:23:22 +1000 (EST)
Date: Wed, 20 Aug 2008 11:23:19 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <9e4733910808200755y1128ae56p6a1235684bfbb3ec@mail.gmail.com>
Message-ID: <alpine.DEB.1.10.0808201122260.23571@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <1219114600.8062.15.camel@pasglop>
	<alpine.DEB.1.10.0808182304300.13401@gandalf.stny.rr.com>
	<1219119431.8062.35.camel@pasglop>
	<1219216705.21386.46.camel@pasglop>
	<alpine.DEB.1.10.0808200913070.13132@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0808200916090.13132@gandalf.stny.rr.com>
	<48AC1DD8.9080702@extricom.com>
	<alpine.DEB.1.10.0808200941560.13132@gandalf.stny.rr.com>
	<48AC23F4.80900@extricom.com>
	<9e4733910808200755y1128ae56p6a1235684bfbb3ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Alan Modra <amodra@au1.ibm.com>,
	Scott Wood <scottwood@freescale.com>, Eran Liberty <liberty@extricom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 20 Aug 2008, Jon Smirl wrote:
> > >
> > > > c00bb690:       bb 0b ff e0     lmw     r24,-32(r11)
> > > > c00bb694:       7c 08 03 a6     mtlr    r0
> > > > c00bb698:       4e 80 00 20     blr
> > > >
> > > >
> > >
> > > Yep, you have the same bug in your compiler.
> > >
> > > -- Steve
> > >
> > >
> >  Hmm... so whats now?
> >
> >  Is there a way to prove this scenario is indeed the one that caused the
> > opps?
> 
> Manually edit the broken binary to change the order of the restore and
> see if the problem disappears. That will keep everything else
> constant.

Does it only happen on this function? Or is it happening on others as 
well. So manually fixing it here won't help much unless we fix it 
everywhere.

-- Steve
