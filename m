Subject: Re: linuxppc-2.5 fixlets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Stefan Berndtsson <stefan@nocrew.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <XFMail.20030822144655.pochini@shiny.it>
References: <XFMail.20030822144655.pochini@shiny.it>
Content-Type: text/plain
Message-Id: <1061556959.813.18.camel@gaston>
Mime-Version: 1.0
Date: Fri, 22 Aug 2003 14:55:59 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-08-22 at 14:46, Giuliano Pochini wrote:
> > Does this set contain any audio fixes (either alsa or dmasound) for
> > the tumbler (ibook2 - late 2001)?
> >
> > Alsa does not seem to produce any sound, whatever I try to do (including
> > messing around with mute), and dmasound doesn't compile at all.
>
> ALSA does not support Mac sound chips very well yet. I also have problems
> with a G4mdd (Snapper audio).

The Alsa code base is so much cleaner that I recommend people interested
in looking at it to work with Takashi into fixing his code base, there's
really no point in continuing artificial life support for dmasound on
pmac, that codebase is way to messy and confused (and 2.6 doesn't have
the up-to-date one which is in 2.4 anyway).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
