Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8213E1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 14:52:10 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BF203140077
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2014 14:52:09 +1100 (AEDT)
Message-ID: <1414468319.364.211.camel@pasglop>
Subject: Re: powerpc: Replace __get_cpu_var uses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 28 Oct 2014 14:51:59 +1100
In-Reply-To: <1414447475.1913.1.camel@concordia>
References: <alpine.DEB.2.11.1410211520470.20253@gentwo.org>
 <alpine.DEB.2.11.1410271055380.18104@gentwo.org>
 <1414444233.364.192.camel@pasglop> <1414447475.1913.1.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Christoph Lameter <cl@linux.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-28 at 09:04 +1100, Michael Ellerman wrote:
> On Tue, 2014-10-28 at 08:10 +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2014-10-27 at 10:57 -0500, Christoph Lameter wrote:
> > > Ping? We are planning to remove support for __get_cpu_var in the
> > > 3.19 merge period. I can move the definition for __get_cpu_var into the
> > > powerpc per cpu definition instead if we cannot get this merged?
> > 
> > Yes, yes, I know, we should merge that, Michael, can you still throw
> > that in ?
> 
> For 3.18, nah. We didn't even see it until after the merge window had closed.

No, we did see it a long time ago Michael, we just forgot about it. We
should put it in, everybody else has their equivalent.

> I realise they're all fairly simple translations, but it's too big and too easy
> for one of them to be wrong.
> 
> I'm happy to put it in a topic branch for 3.19, or move the definition or
> whatever, your choice Christoph.

But then we'll have a tricky sync needed to make sure the removal of
__get_cpu_var() doesn't get into Linus tree before this. Unless we just
ack the whole lot and let Christoph carry it in the same branch where
the removal is.

Ben.
