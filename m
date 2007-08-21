Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Tue, 21 Aug 2007 11:35:39 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: pterry@micromemory.com
Subject: Re: Patches for ppc?
Message-ID: <20070821113539.097bec87@weaponx.rchland.ibm.com>
In-Reply-To: <1187712684.13726.32.camel@pterry-fc6.micromemory.com>
References: <46C5519E.6010300@dutchspace.nl>
	<1187353616.2778.358.camel@shinybook.infradead.org>
	<46C5B288.2010308@dutchspace.nl>
	<1187361603.2778.382.camel@shinybook.infradead.org>
	<46C5B40F.5040209@dutchspace.nl>
	<acbcf3840708171628k242e96ffl2b65011bf6d39512@mail.gmail.com>
	<20070821052514.GC21169@localhost.localdomain>
	<ae3d7296a5c3e83f19817a04841d099f@kernel.crashing.org>
	<1187712684.13726.32.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Aug 2007 09:11:24 -0700
Phil Terry <pterry@micromemory.com> wrote:

> On Tue, 2007-08-21 at 17:14 +0200, Segher Boessenkool wrote:
> > > It's not a question of indivudual files being copied over - things are
> > > done differently in arch/powerpc.  Things are gradually being ported
> > > over to arch/powerpc as people get the time - that's why arch/ppc
> > > isn't gone yet.
> > 
> > And to be blunt, one of the points of arch/powerpc vs. arch/ppc is
> > to actually leave behind some stuff.  "If no one ports it, no one
> > wants it".
> 
> So am I alone in getting a mixed message from "Linux community" to
> "embedded community"? 

I don't think so..

> On the one hand we have people like GKH telling embedded people to stop
> being private company/device specific forks but to submit their hardware
> to the tree where it will be supported "for free" by the kernel hackers,
> saving us the "chore" of supporting "our" code through all the kernel
> changes and forever chasing it.

Yes.  Just submit it to the arch/powerpc tree instead of arch/ppc.  But
this is only an issue for the _initial_ submit, and only while the
merge is on-going.

> On the other hand we have people telling us that because we are too lazy
> to support "our" code the kernel guys aren't going to pull it forward
> for us.

That's more of a issue for _existing_ code, not new code.

> So in fact people 3rd party people like me are in between real problems,
> we base our code on say a Freescale chip, who submit to the kernel to
> save their support issues and we base our code on that. Now, the
> Freescale guys are too busy porting their "latest" chips across the
> PPC/Powerpc divide to port the "old" stuff so it gets "left behind".

Or maybe it's just not ported yet?

> That old stuff is still selling and the people who based code on it had
> the expectation that the code would continue to be supported. So now I'm
> being told not only to "port my stuff or lose it" but now also port
> freescale's stuff or lose it.

Well... it's not really going away until June 2008.  There's time.

josh
