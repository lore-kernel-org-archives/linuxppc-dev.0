Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1187716337.13726.48.camel@pterry-fc6.micromemory.com>
References: <46C5519E.6010300@dutchspace.nl>
	<1187353616.2778.358.camel@shinybook.infradead.org>
	<46C5B288.2010308@dutchspace.nl>
	<1187361603.2778.382.camel@shinybook.infradead.org>
	<46C5B40F.5040209@dutchspace.nl>
	<acbcf3840708171628k242e96ffl2b65011bf6d39512@mail.gmail.com>
	<20070821052514.GC21169@localhost.localdomain>
	<ae3d7296a5c3e83f19817a04841d099f@kernel.crashing.org>
	<1187712684.13726.32.camel@pterry-fc6.micromemory.com>
	<116C1903-CE42-4066-8524-F9216003BE9A@kernel.crashing.org>
	<1187716337.13726.48.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a027a1e105da18fb17125235332c8504@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Patches for ppc?
Date: Tue, 21 Aug 2007 20:09:43 +0200
To: pterry@micromemory.com
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

> So then I get worried, how do I know
> who's plan and schedule include/excludes my board/chip/issue?

The arch/ppc -> arch/powerpc changeover is exceptional for various
reasons.

First, it is a huge change taking multiple years to complete.
Only recently it has been decided when to finally drop arch/ppc
completely; and that's not going to happen until almost a year
from now.

Secondly, it really does change many things at the core.  It
is almost impossible for people without in-depth knowledge of
specific hardware too correctly port support code for that
hardware over those core changes, and certainly impossible to
actually test the ported code.  So the only sane approach was
to only port the hardware support code people _did_ have access
to.  Which isn't to say the other platforms still "in demand"
will be left behind of course, some are still being ported over,
and there is nothing preventing such a port even after arch/ppc
is dead and gone either.

Thirdly, Greg KH is talking more about generic drivers (PCI
device drivers, for example) than about low-level platform code;
at least that's my impression.  The good news is that in the
arch/powerpc world much more of the low-level stuff will be
abstracted away, or at least sanely abstracted at all, so in
the future we won't have all that many problems making even
the biggest core changes anymore.

> I was trying to raise that generic issue, which is why I tried to be
> generic. Didn't mean to gore anyones ox.

Don't worry, you didn't offend anyone as far as I can see :-)

All of the "more generic" stuff (e.g., CPU/SoC support) should
be ported over soon enough (if not, shout); some more specific
stuff (support for some specific board, etc.) you will have to
do yourself, or find someone else to do it for you.  And you can
always ask for help here, we're all very helpful and friendly
here (if you believe that ;-) )


Segher
