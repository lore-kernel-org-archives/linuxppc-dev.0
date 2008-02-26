Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0CBADDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 18:39:32 +1100 (EST)
Message-Id: <8B0E09C7-BA68-4994-9AB6-36F400F65832@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1203762305.13162.17.camel@johannes.berg>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: MPC8540 : What's "SPE used in kernel" ?
Date: Tue, 26 Feb 2008 01:39:20 -0600
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
	<08A7CD2B-27EA-4C97-9220-314E36BBBAA6@freescale.com>
	<20080223092458.GA6873@10.1.86.20>
	<1203760269.13162.11.camel@johannes.berg>
	<20080223101707.GA7194@10.1.86.20>
	<1203762305.13162.17.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org, Philippe De Muyter <phdm@macqel.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 23, 2008, at 4:25 AM, Johannes Berg wrote:

>
>> But as I said in the same mail, processes still dies unexpectedly.
>
> Yeah, no idea though. I guess you could try putting that into the
> arch/ppc Makefile, but arch/ppc will be removed this year so you don't
> want to rely on it.

Its been removed (or will be for 2.6.25).

What compiler version are you using?

- k
