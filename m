Return-Path: <mgreer@mvista.com>
Date: Wed, 19 Jul 2006 15:10:19 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
Message-ID: <20060719221019.GA32203@mag.az.mvista.com>
References: <20060518002142.GA23182@mag.az.mvista.com>
	<1147930376.17679.72.camel@localhost.localdomain>
	<20060523005846.GA15797@mag.az.mvista.com>
	<Pine.LNX.4.60.0607192144310.6432@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0607192144310.6432@poirot.grange>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Guennadi,

On Wed, Jul 19, 2006 at 10:02:01PM +0200, Guennadi Liakhovetski wrote:
> Mark, Ben,
> 
> On Mon, 22 May 2006, Mark A. Greer wrote:
> 
> > Thanks for your time, Ben.  Sorry for taking so long to get back to you.
> 
> don't have much to comment to specific points, but quoting the entire 
> discussion below in case you'll want to further add to it.

Ben and I have talked a little bit privately and the ball is in my court
to produce a set of patches.  To that end, I have them ready so expect to
see them shortly.

> What's the status of this work? Mark, have you been further working on 
> your port?

Patches to come...

> I'd like to integrate kurobox/linkstation support with 
> sandpoint (also 8241). I think, it would be very interesting as it would 
> allow us to develop / test the "universal" kernel idea, and at the same 
> time explore the limits of board-specific support. Kurobox have a couple 
> of very nice "specialities", like a serially attached AVR acting as a 
> power-manager, thus requiring __special__ halt and reboot callbacks (so, 
> please, Ben, don't remove them).
>
> Any progress with fdt-parsing library for the wrapper / kernel and with 
> replacing hard-coded constants and tables with dt-entries?

No real progress with making a library because even though a lot of
functionality is duplicated, most of the kernel code does it on an
internal representation of the fdt and not on the actual fdt.  The
bootwrapper code needs to work directly on the fdt so I didn't bother
library-izing it.  Once the dust settles, we can library-ize the duplicate
code but for now, its all in arch/powerpc/boot/fdt.c (in my upcoming patches).

> I'd love to discuss the stuff and come to an acceptable design / APIs.

Me too. :)

Mark
