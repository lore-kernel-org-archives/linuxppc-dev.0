Date: Thu, 3 Aug 2000 11:33:51 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Tom Gall <gall@rochcivictheatre.org>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <3988C944.74A6FC45@rochcivictheatre.org>
Message-ID: <Pine.LNX.4.10.10008031130470.12417-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > While I also enjoyed the flexibility on m68k, some of it was paid for in
> > terms of increased complexity in head.S and entry.S (and especially head.S
> > wasn't a bit pretty). I'm not sure how your trouble with the embedded
> > systems can be solved, we kept separate head.S versions for Macs and other
> > machines for a while as well because things just got too confusing. Maybe
> > we need to keep separate versions for embedded and other systems here?
>
> Hi All,
>
>   I think we don't want to get too carried away with pulling things
> apart here. Afterall I think we'd all like to be able to continue to
> pick up a distro with a bootable kernel that works over a wide variety
> of machines instead of 10 different kernels to choose from depending on
> which box you've got.

That's exactly what won't work now. A kernel built for PowerMac won't work
on embedded systems or APUS, and maybe not even on PReP or CHRP.

>   Now obvoiusly I'm going a little overboard here but hopefully you
> might see what I'm saying. Granted embedded boxes aren't going to care
> about booting from the install cd but I think the rest of us sure do!

I don't see where we would conflict, all I said was maybe keep embedded
separate. By all means unify the rest if at all possible.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
