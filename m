Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16DFBDDDE9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 15:26:19 +1100 (EST)
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1201450409.1931.23.camel@thor.sulgenrain.local>
References: <1200659696.23161.81.camel@thor.sulgenrain.local>
	<1201013786.4726.28.camel@thor.sulgenrain.local>
	<1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy> <1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop> <1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050757.GB14177@linux.vnet.ibm.com>
	<1201450409.1931.23.camel@thor.sulgenrain.local>
Content-Type: text/plain; charset=utf-8
Date: Mon, 28 Jan 2008 15:25:24 +1100
Message-Id: <1201494324.6815.171.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	vatsa@linux.vnet.ibm.com, Peter Zijlstra <a.p.zijlstra@chello.nl>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-01-27 at 17:13 +0100, Michel Dänzer wrote:
> 
> > Do you see behavior change (from good->bad) immediately after
> applying that patch 
> > during your bisect process?
> 
> Yes, confirmed by trying that commit and its parent again.

Just to be paranoid... can you try with a different gcc version in case
something gets miscompiled ?

Ben.
