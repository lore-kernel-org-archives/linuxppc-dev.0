Date: Wed, 24 Mar 2004 15:25:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Tolunay Orkun <listmember@orkun.us>, Wolfgang Denk <wd@denx.de>
Subject: Re: IBM 440GX, Ocotea...
Message-ID: <20040324222512.GM7126@smtp.west.cox.net>
References: <20040323164441.06AA0C1157@atlas.denx.de> <1080061066.8019.70.camel@linpc003.aimsys.nl> <406080CB.5040403@embeddededge.com> <4B2752C7-7D6A-11D8-BC79-000A95B15278@aimsys.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B2752C7-7D6A-11D8-BC79-000A95B15278@aimsys.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Mar 24, 2004 at 09:07:28AM +0100, Jaap-Jan Boor wrote:

> On Mar 23, 2004, at 19:24, Dan Malek wrote:
>
> >Jaap-Jan Boor wrote:
> >
> >>from what 'official ppc' tree do patches eventually get into the
> >>official linux kernel tree(s) at kernel.org?
> >>only linuxppc-2.4? Or all?
> >
> >It seems to be a circuitous route that I don't even understand
> >anymore.  Sometime stuff I check in gets there, sometimes not. :-)
>
> and you have never found out the conditions when something
> get's in (only when submitted at friday the 13th or something?)

Um, yeah.  I'm hoping 2.6 will be different from 2.4 in that regard. :)

> >http://penguinppc.org/dev/kernel.shtml tries to explain it.
>
>
> this states you should build/submit patches against kernel.org's
> trees, which is quite different from linuxppc-2.[45], which is probably
> Tom Rini's checkout of kernel.org's tree with all ppc patches.
> Or is it?

linuxppc-2.[45] are children of the linux-2.[45] trees, and contain
stuff that's not quite ready to go out, _but_will_be_soon_ or has been
put in a tree for Linus/Marcelo, but they haven't pulled yet.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
