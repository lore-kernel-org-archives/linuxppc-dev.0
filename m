Date: Mon, 18 Mar 2002 11:48:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
Message-ID: <20020318184842.GA8155@opus.bloom.county>
References: <20020315170433.GA691@opus.bloom.county> <0203160821.AA28474@ivan.Harhan.ORG> <20020316151505.GA713@opus.bloom.county> <3C960D92.37FE6EFF@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C960D92.37FE6EFF@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 18, 2002 at 10:53:54AM -0500, Mark A. Greer wrote:
> Tom Rini wrote:
>
> > > Ditto. BTW, do you really want that 115200 thing in there? I've axed it in my
> > > personal tree, but didn't include that in my posted patch to reduce the patch
> > > scare factor.
> >
> > I'd be willing to bet $5 it's from Troy.  IMHO, 9600 is the defacto
> > default rate, but Troy likes 'fast' serial consoles.
>
> No, its from me.  The reason its 115200 is because that's what that version of DINK that
> comes with it uses.  Having to set minicom to 115200, then change it to 9600 in the
> middle of a boot doesn't make sense to me.
> Why do what DINK does??  Because that's what comes with the board.

Well if DINK is what's doing it, then yes, that is the sane choice of
speeds.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
