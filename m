Subject: Re: linuxppc-2.5 fixlets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <XFMail.20030822181838.pochini@shiny.it>
References: <XFMail.20030822181838.pochini@shiny.it>
Content-Type: text/plain
Message-Id: <1061570046.754.0.camel@gaston>
Mime-Version: 1.0
Date: Fri, 22 Aug 2003 18:34:06 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-08-22 at 18:18, Giuliano Pochini wrote:
> >> ALSA does not support Mac sound chips very well yet. I also have problems
> >> with a G4mdd (Snapper audio).
> >
> > The Alsa code base is so much cleaner that I recommend people interested
> > in looking at it to work with Takashi into fixing his code base,
>
> Is there some hw documentation ?

Some of the chips behind the i2s bus are documented (the Texas ones are)
and there is Apple source code.

Ben


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
