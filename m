Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36EEADDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 16:02:31 +1100 (EST)
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Gatliff <bgat@billgatliff.com>
In-Reply-To: <48EED4D1.2040506@billgatliff.com>
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop> <48EED4D1.2040506@billgatliff.com>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 16:02:23 +1100
Message-Id: <1223614943.8157.158.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-09 at 23:06 -0500, Bill Gatliff wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2008-10-08 at 11:43 -0500, Bill Gatliff wrote:
> >> This series proposes a "generic PWM" driver API.
> >>
> >> This proposed API is motivated by the author's need to support
> >> pluggable devices; a secondary objective is to consolidate the
> >> existing PWM implementations behind an agreeable, consistent,
> >> redundancy-reducing interface.
> > 
> >  .../...
> > 
> > You should send your patches to the main linux kernel list !
> 
> Perhaps.  But it seemed more relevant to this crowd, and the linux-embedded
> crowd, and the linux-arm-kernel crowd.

Sure but if you want then applied, you probably still need lkml and
andrew.

> At the very least, it made sense to present it in this sort of venue first.
> Given that it's a "global" API proposal, I suppose I'll have to run it by lkml
> at some point--- unless one of the aforementioned groups can mainline it themselves.

For review and comments, sure.

Cheers,
