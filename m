Date: Tue, 27 Nov 2001 12:26:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Simon Winwood <sjw@cse.unsw.edu.au>
Cc: Matt Porter <mporter@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More walnut boottime "fun"
Message-ID: <20011127122607.M13091@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011127103042.A11612@cse.unsw.edu.au> <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net> <20011127050754.B15728@cx258813-a.chnd1.az.home.com> <20011128061857.A390@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011128061857.A390@cse.unsw.edu.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Nov 28, 2001 at 06:18:57AM +1100, Simon Winwood wrote:
> On Tue, Nov 27, 2001 at 05:07:54AM -0700, Matt Porter wrote:
> > On Mon, Nov 26, 2001 at 10:17:28PM -0700, Tom Rini wrote:
> > >
> >
>
> [...]
>
> > That said, the two stage relocator is "The Right Thing To Do(tm)".
> > It only needs to be two stage, though when the load point > -Ttext.
>
> 	I have fixed the relocate code so it does it in 2 stages ...
> first it moves the relocate code, then it relocates the image, either
> start first or end first, so it doesn't overwrite itself.

Yay.  I was just about to start on that now that I fixed the minor
things upsetting my rpx.  I'll go and test this around and commit it or
something similar today hopefully.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
