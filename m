Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <e27030866ac1c1efda319294eba6b626@embeddededge.com>
References: <20050406223751.E4297C108D@atlas.denx.de>
	<e27030866ac1c1efda319294eba6b626@embeddededge.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 10:13:08 +1000
Message-Id: <1112832788.9518.229.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel SCM saga..
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-04-06 at 19:33 -0400, Dan Malek wrote:
> On Apr 6, 2005, at 6:37 PM, Wolfgang Denk wrote:
> 
> > are there any plans yet how to continue PPC  kernel  development  now
> > that Linus (and probably others, too) stopped using BitKeeper?
> 
> For all practical purposes, we have stopped using it as intended long
> ago.   When we first started, those of us responsible for maintaining 
> part
> of the sources simply continuously pushed updates.  Very efficient, 
> everyone
> saw what was up to date.  Since 2.4, we have all been passing patches
> around,  pushing things into BK didn't seem to matter, and usually
> were ignored or lost.  People responsible for certain areas of 
> maintenance
> are now just bypassed with sometimes bad patches just given to Andrew
> directly.  We may as well go back to using CVS and passing patches
> around, since it easier to do that than the way we have been using BK.

The problem is that we used to have our "own" tree which ended up beeing
a grab bag for all the crap on earth and would drift from upstream in
unmanageable ways.

We are now working much more directly with upstream, and it's not about
random people sending random patches to akpm, for most arch patches,
andrew is actually asking us (or rather paulus) whether to accept or not
the patch. It does sometimes slip through but that's minimal.

If you feel that your stuff isn't properly going upstream in time, then
maybe that is because you aren't sending the patch to the right person
or putting it in the right place ?

All patches posted to linuxppc-dev and linuxppc64-dev are tracked by an
automatic system. They may take some time to go upstream, but they are
never lost.

Ben.
