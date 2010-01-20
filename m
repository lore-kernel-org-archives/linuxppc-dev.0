Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] powerpc: implement arch_scale_smt_power for Power7
In-reply-to: <1264020517.4283.1117.camel@laptop>
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<1264020517.4283.1117.camel@laptop>
Date: Thu, 21 Jan 2010 10:58:01 +1300
Message-ID: <29111.1264024681@neuling.org>
Cc: ego@in.ibm.com, Andreas Herrmann <andreas.herrmann3@amd.com>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > On Power7 processors running in SMT4 mode with 2, 3, or 4 idle threads 
> > there is performance benefit to idling the higher numbered threads in
> > the core.  
> 
> So this is an actual performance improvement, not only power savings?

It's primarily a performance improvement.  Any power/energy savings
would be a bonus.  

Mikey
