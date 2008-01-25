Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E389EDDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 18:04:09 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1201244082.6815.128.camel@pasglop>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy>  <1201244082.6815.128.camel@pasglop>
Content-Type: text/plain
Date: Fri, 25 Jan 2008 18:03:38 +1100
Message-Id: <1201244618.6815.130.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-25 at 17:54 +1100, Benjamin Herrenschmidt wrote:
> 
> Here, I do the test of running 4 times the repro-case provided by Michel
> with nice 19 and a dd eating CPU with nice 0.
> 
> Without this option, I get the dd at 100% and the nice 19 shells down
> below it with whatever is left of the CPUs.
> 
> With this option, dd gets about 50% of one CPU and the niced processes
> still get most of the time.

FYI. This is a 4 way G5 (ppc64)

Ben.
