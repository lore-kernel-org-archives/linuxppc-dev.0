Date: Thu, 25 Mar 2004 14:20:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tolunay Orkun <listmember@orkun.us>
Cc: Jaap-Jan Boor <jjboor@aimsys.nl>,
	linuxppc-embedded@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>, Wolfgang Denk <wd@denx.de>
Subject: Re: IBM 440GX, Ocotea...
Message-ID: <20040325212002.GO13366@smtp.west.cox.net>
References: <20040323164441.06AA0C1157@atlas.denx.de> <1080061066.8019.70.camel@linpc003.aimsys.nl> <406080CB.5040403@embeddededge.com> <4B2752C7-7D6A-11D8-BC79-000A95B15278@aimsys.nl> <20040324222512.GM7126@smtp.west.cox.net> <1B149F27-7E32-11D8-BB55-000A95B15278@aimsys.nl> <20040325194008.GM13366@smtp.west.cox.net> <56117.216.110.51.8.1080249262.squirrel@www.orkun.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56117.216.110.51.8.1080249262.squirrel@www.orkun.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 25, 2004 at 03:14:22PM -0600, Tolunay Orkun wrote:
> >> >linuxppc-2.[45] are children of the linux-2.[45] trees, and contain
> >> >stuff that's not quite ready to go out, _but_will_be_soon_ or has been
> >> >put in a tree for Linus/Marcelo, but they haven't pulled yet.
> >>
> >> ok thanks (and linuxppc-2.5 should be used to get something into 2.6?)
> >
> > If it's something which isn't quite ready yet, it should go into
> > linuxppc-2.5.  Otherwise, it should go to linux-2.5, either via Andrew
> > Morton, or Paul or Ben sending it to Linus.
>
> If the chnage goes directly to linux-2.[56] tree directly is it also
> applied to linuxppc-2.5 as well? How do you keep it in sync with
> kernel.org tree?

The linuxppc-2.5 tree is a child of the linux-2.5 tree.  Once a change
gets into the linux-2.5 tree, we can pull it into the linuxppc-2.5 tree.
So it becomes just another change we get.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
