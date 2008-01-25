Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9DC0CDE097
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:12 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1201273484.6090.12.camel@thor.sulgenrain.local>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy>  <1201244082.6815.128.camel@pasglop>
	<1201260867.6293.38.camel@thor.sulgenrain.local>
	<1201273484.6090.12.camel@thor.sulgenrain.local>
Content-Type: text/plain; charset=utf-8
Date: Sat, 26 Jan 2008 08:10:29 +1100
Message-Id: <1201295429.6815.145.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, vatsa <vatsa@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-01-25 at 16:04 +0100, Michel Dänzer wrote:
> > Hmm, interesting. As I said before, I thought I had tested with this
> > disabled and not seen a difference, but I'll try again to confirm.
> 
> So, 2.6.24 final is indeed much better with this disabled, but still
> not
> as good as 2.6.23: While I can reliably move a window again while the
> infinite loop is running, it still stutters badly every couple of
> seconds. With 2.6.23 this is smooth all the time.

This is with or without fair group scheduler enabled ?

Ben.
