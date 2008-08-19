Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 5550FDDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 06:15:18 +1000 (EST)
Date: Tue, 19 Aug 2008 16:15:15 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Eran Liberty <liberty@extricom.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <48AAB7FF.4070502@extricom.com>
Message-ID: <alpine.DEB.1.10.0808191614380.4957@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <48A9BEA3.10906@extricom.com>
	<alpine.DEB.1.10.0808181439480.796@gandalf.stny.rr.com>
	<48AAB7FF.4070502@extricom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 19 Aug 2008, Eran Liberty wrote:

> Steven Rostedt wrote:
> >   
> > > Testing tracer sched_switch: PASSED
> > > Testing tracer ftrace: PASSED
> > > Testing dynamic ftrace: PASSED

Do you have PREEMPT_TRACER enabled, or any other tracer for that matter?

-- Steve

> > > 
> > > Oops: Exception in kernel mode, sig: 11 [#1]
> > > Exsw1600
> > > Modules linked in:
> > > NIP: c00bbb20 LR: c00bbb20 CTR: 00000000
> > >     
> > 
