Date: Fri, 16 Feb 2001 09:00:16 -0700
From: Matt Porter <mporter@mvista.com>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: Matt Porter <mporter@mvista.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME5100: kernel hangs in dcache_init
Message-ID: <20010216090016.D20336@beef.az.mvista.com>
References: <20010216044002.B8737@cx258813-a.chnd1.az.home.com> <NDBBIFIMCKPOADMAJOKMEEOECOAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBIFIMCKPOADMAJOKMEEOECOAA.s.coluccini@caen.it>; from s.coluccini@caen.it on Fri, Feb 16, 2001 at 04:37:42PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 16, 2001 at 04:37:42PM +0100, Stefano Coluccini wrote:
> >
> > Did you make sure it's getting the correct memory size?
>
> I think the problem is not there because the printks before the hang shows
> the correct value (I have inserted the printouts of my boot process at the
> bottom of the message)
>
> >  Assuming you're
> > trying to port into the existing prep_* framework, it does use residual
> > data to determine memory size.  That used to be reasonable but the
> > newer MCG boards are not providing any useful information in
> > residual data, I'd imagine this is also the case with the 5100.  That's
> > why the new MCG ports in the development tree no longer rely on residual
> > data.
>
> Yes, I'm working on prep_* framework, but the residual seems significant and
> correct (to my un-expert eyes :-)

Ok, well, it was just a guess.  To be honest, I'd throw my Abatron on
there at this point.  The alternative is a liberal sprinkling of
printk's and/or kgdb unless somebody else has a strong clue as to the
source of the problem.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
