Message-ID: <3831CE5A.DE7F3566@astro.wisc.edu>
Date: Tue, 16 Nov 1999 15:36:26 -0600
From: Matt Haffner <haffner@astro.wisc.edu>
Reply-To: haffner@astro.wisc.edu
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: atong@uiuc.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree, E, and refresh rates...
References: <Pine.LNX.4.10.9911161408530.3875-100000@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
> 
> On Tue, 16 Nov 1999, Matt Haffner wrote:
> 
> > I was curious if any of you had seen my posting on the users list a bit
> > ago about problems that cropped up with Enlightenment 0.16 related to
> > monitor refresh rates (B&W/400). There are two minor issues on this
> > topic.
> 
> E 0.16.2 & anthonys FBDev seem happy here..

OK... I'll have to try out 16.2. I've got 16.1 installed right now.
Odd...

> > There seems to be a general problem (at least on my system... I haven't
> > seen corroboration yet) that XFree chooses the _lowest_ vertical refresh
> > modeline instead of the highest one supported by the monitor. I have
> > lines like
> 
> It takes the 1st one that fits, iirc.

Ahhhh... Thanks. I see my misunderstanding with this now. In the
XF86Config file, there's a statement: 
                                  vvvv
# monitor). With these modes, the best standard mode that your monitor
# and video card can support for a given resolution is automatically
# used.

I had interpreted that to mean best refresh rate (and thought I read
that elsewhere too). But checking the man page it says it takes the
first valid one. 

Is it possible then for XConfigurator spit out the modelines in reverse
order from what it does now? It looks like it's in order of increasing
hsync right now, but maybe decreasing hsync or vrefresh would be better?
That way we get the highest refresh rate right out of the box. Totally
trival though :)

Thanks again...

mh
--
Matt Haffner                      /|------|\    University of Wisconsin
Dept. of Astronomy               /|--------|\            Madison
haffner@astro.wisc.edu          /|----------|\  
           WHAM project -- http://www.astro.wisc.edu/wham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
