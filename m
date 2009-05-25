Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E4AEDE143
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 14:35:08 +1000 (EST)
Subject: Re: can't flush tlb on e500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hideo Saito <hsaito.ppc@gmail.com>
In-Reply-To: <20090525.103334.68564567.saito@densan.co.jp>
References: <20090525.103334.68564567.saito@densan.co.jp>
Content-Type: text/plain
Date: Mon, 25 May 2009 14:20:22 +1000
Message-Id: <1243225222.24376.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-05-25 at 10:33 +0900, Hideo Saito wrote:
> 
> This report came from LKML, although I should post it here first,
> the report said that there is a regression in linux-2.6.29 as to
> flushing a TLB entry that was going to be re-used when a context
> overflowed from the TLB.
> 
> On Fri, May 22, 2009 at 6:27 PM, Benjamin Herrenschmidt wrote:
> > Have you verified that this change fixes your problem ?
> 
> I tested using "hackbench 100" and it was done successfully on my
> platform with e500(MPC8548).
> 
> >
> > Can you re-submit to linuxppc-dev@ozlabs.org mailing list, along
> with
> > proper changeset comment and signed-off-by: line ?
> 
> I am sorry I don't know as to the proper changeset comment.
> 
Well, that simply means a proper description of the bug and
the fix :-)

I'll cook up one.

Cheers,
Ben.
