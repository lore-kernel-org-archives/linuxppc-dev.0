Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id D9B00DF0DA
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 04:33:59 +1000 (EST)
Date: Wed, 20 Aug 2008 14:33:57 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Eran Liberty <liberty@extricom.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <48AC6120.1080400@extricom.com>
Message-ID: <alpine.DEB.1.10.0808201431140.3035@gandalf.stny.rr.com>
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
	<48AC6120.1080400@extricom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Alan Modra <amodra@au1.ibm.com>,
	Scott Wood <scottwood@freescale.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 20 Aug 2008, Eran Liberty wrote:
> mon> X
> ~ #
> 
> And took it for a test drive
> ~# while [ 1 ] ; do find / > /dev/null ; echo .  ; done
> .
> .
> .
> [ 10 min later ]
> .
> .
> .
> 
> Stable! Yeepee.

Eran, thanks a lot for testing this!

> 
> So how do we get this to be right in the first place and everywhere?
> 

This is a bug in gcc, and should be mentioned to the gcc maintainers.

-- Steve
