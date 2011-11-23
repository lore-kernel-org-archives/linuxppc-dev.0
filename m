Return-Path: <dgibson@ozlabs.org>
Date: Wed, 23 Nov 2011 12:15:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc: dts: Fix canyonlands EMAC interrupt map
Message-ID: <20111123011517.GA5183@truffala.fritz.box>
References: <1321945877-22802-1-git-send-email-tinamdar@apm.com>
 <1321996600.14573.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321996600.14573.0.camel@pasglop>
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

On Wed, Nov 23, 2011 at 08:16:40AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2011-11-22 at 12:41 +0530, Tanmay Inamdar wrote:
> > Fixing interrupt mapping of EMAC for canyonlands
> 
> The previous stuff was odd .... but was it broken ?
> 
> It was done this way because the EMAC actually has more interrupts than
> that which are routed to different UICs, and so doing a local map this
> way allows to target multiple parents.

Well, in the canyonlands case, it appears that the interrupts went to
the same pic, so the simpler representation should be correct as
well.  However, there certainly are boards where they go to multiple
pics, so we need this interrupt-map trick.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
