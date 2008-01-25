Return-Path: <michel@tungstengraphics.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 5ACE2DDE36
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 22:34:35 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so551756fgg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 03:34:34 -0800 (PST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: benh@kernel.crashing.org
In-Reply-To: <1201244082.6815.128.camel@pasglop>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy>  <1201244082.6815.128.camel@pasglop>
Content-Type: text/plain; charset=utf-8
Date: Fri, 25 Jan 2008 12:34:27 +0100
Message-Id: <1201260867.6293.38.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-25 at 17:54 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2008-01-23 at 13:42 +0100, Peter Zijlstra wrote:
> > Another question, do you have:
> >   CONFIG_FAIR_GROUP_SCHED=y
> > 
> > if so, does flipping that off have any effect?
> 
> Yes.
> 
> Here, I do the test of running 4 times the repro-case provided by Michel
> with nice 19 and a dd eating CPU with nice 0.
> 
> Without this option, I get the dd at 100% and the nice 19 shells down
> below it with whatever is left of the CPUs.
> 
> With this option, dd gets about 50% of one CPU and the niced processes
> still get most of the time.

Hmm, interesting. As I said before, I thought I had tested with this
disabled and not seen a difference, but I'll try again to confirm.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
