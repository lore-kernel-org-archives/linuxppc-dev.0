Date: Thu, 26 Aug 1999 23:33:07 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: BootX enhancement request
In-Reply-To: <Pine.LNX.4.10.9908241456210.17842-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.4.05.9908262332140.1005-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Aug 1999, Geert Uytterhoeven wrote:

> 
> On Tue, 24 Aug 1999, Benjamin Herrenschmidt wrote:
> > On Tue, Aug 24, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:
> > >The second is that macos is now using mode numbers > 20.  I haven't
> > >worked out the correspondence yet.
> > 
> > MacOS no longer relies on the nvram setting. Video drivers are free to
> > put whatever they want in their own device tree node, and usually store
> > an nvram value for the mode there, but this is proprietary and depends on
> > the driver. MacOS itself now stores the various infos in a preferences
> > file. The old "Monitors" control panel still updates the old pram
> > location with a mode value but the meaning is not guaranteed (can be
> > driver specific).
> 
> Thus I can remove the nvram code from atyfb?

Why?  It works fine on lots of older machines w/ ati cards and older MacOS
versions.  If you remove it I can garrenty people will notice and
complain.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
