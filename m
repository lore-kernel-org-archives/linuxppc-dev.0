Date: Thu, 25 Mar 2004 12:40:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>,
	Tolunay Orkun <listmember@orkun.us>, Wolfgang Denk <wd@denx.de>
Subject: Re: IBM 440GX, Ocotea...
Message-ID: <20040325194008.GM13366@smtp.west.cox.net>
References: <20040323164441.06AA0C1157@atlas.denx.de> <1080061066.8019.70.camel@linpc003.aimsys.nl> <406080CB.5040403@embeddededge.com> <4B2752C7-7D6A-11D8-BC79-000A95B15278@aimsys.nl> <20040324222512.GM7126@smtp.west.cox.net> <1B149F27-7E32-11D8-BB55-000A95B15278@aimsys.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1B149F27-7E32-11D8-BB55-000A95B15278@aimsys.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 25, 2004 at 08:57:47AM +0100, Jaap-Jan Boor wrote:

> On Mar 24, 2004, at 23:25, Tom Rini wrote:
>
> >>>It seems to be a circuitous route that I don't even understand
> >>>anymore.  Sometime stuff I check in gets there, sometimes not. :-)
> >>
> >>and you have never found out the conditions when something
> >>get's in (only when submitted at friday the 13th or something?)
> >
> >Um, yeah.  I'm hoping 2.6 will be different from 2.4 in that regard. :)
>
> ok!
>
> >linuxppc-2.[45] are children of the linux-2.[45] trees, and contain
> >stuff that's not quite ready to go out, _but_will_be_soon_ or has been
> >put in a tree for Linus/Marcelo, but they haven't pulled yet.
>
> ok thanks (and linuxppc-2.5 should be used to get something into 2.6?)

If it's something which isn't quite ready yet, it should go into
linuxppc-2.5.  Otherwise, it should go to linux-2.5, either via Andrew
Morton, or Paul or Ben sending it to Linus.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
