Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9DCF679E6
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 16:37:49 +1000 (EST)
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17476.34830.897083.360572@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<17471.62187.774127.783000@cargo.ozlabs.ibm.com>
	<1145048461.4223.38.camel@localhost.localdomain>
	<17476.31998.168122.413195@cargo.ozlabs.ibm.com>
	<1145340034.4705.55.camel@localhost.localdomain>
	<17476.34830.897083.360572@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 16:37:40 +1000
Message-Id: <1145342260.4705.66.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Becky Bruce <Becky.Bruce@freescale.com>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-04-18 at 16:32 +1000, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > The 970 version bloats the exception prolog significantly... I
> 
> Four instructions, in the external and decrementer interrupt entry
> paths - I don't think that's really significant bloat.

Yeah well.. including a load.. ok, I admit that should be fairly hot...
btw, I suppose you took care of having those local flags in some hot
cache line ? :)

> More likely we'll get more situations like Cell where we come in
> through the soft reset vector after sleep.

Yeah.

Ben.
