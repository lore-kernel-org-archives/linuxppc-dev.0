Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AFB021007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 12:43:06 +1100 (EST)
Message-ID: <1322012538.14573.20.camel@pasglop>
Subject: Re: powerpc: dts: Fix canyonlands EMAC interrupt map
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 23 Nov 2011 12:42:18 +1100
In-Reply-To: <20111123011517.GA5183@truffala.fritz.box>
References: <1321945877-22802-1-git-send-email-tinamdar@apm.com>
 <1321996600.14573.0.camel@pasglop>
 <20111123011517.GA5183@truffala.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Tanmay Inamdar <tinamdar@apm.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-11-23 at 12:15 +1100, David Gibson wrote:
> On Wed, Nov 23, 2011 at 08:16:40AM +1100, Benjamin Herrenschmidt wrote:
> > On Tue, 2011-11-22 at 12:41 +0530, Tanmay Inamdar wrote:
> > > Fixing interrupt mapping of EMAC for canyonlands
> > 
> > The previous stuff was odd .... but was it broken ?
> > 
> > It was done this way because the EMAC actually has more interrupts than
> > that which are routed to different UICs, and so doing a local map this
> > way allows to target multiple parents.
> 
> Well, in the canyonlands case, it appears that the interrupts went to
> the same pic, so the simpler representation should be correct as
> well.  However, there certainly are boards where they go to multiple
> pics, so we need this interrupt-map trick.

Doesn't emac has something like 4 more interrupts that we simply haven't
been bothered wiring up (because we don't use them ?)

Cheers,
Ben.
