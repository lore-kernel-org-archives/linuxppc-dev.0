Message-ID: <3988C944.74A6FC45@rochcivictheatre.org>
Date: Wed, 02 Aug 2000 20:22:12 -0500
From: Tom Gall <gall@rochcivictheatre.org>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <Pine.LNX.4.10.10008021759180.14639-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > Given the flexibility I was used to on m68k[*], I find this a pity as well...
> >
> > Well, it looks like I opened up a big can of worms...........
> >
> > I guess this is something that will get discussed as part of
> > "restructuring" the PowerPC source tree when we jump into 2.5.xx.
>
> While I also enjoyed the flexibility on m68k, some of it was paid for in
> terms of increased complexity in head.S and entry.S (and especially head.S
> wasn't a bit pretty). I'm not sure how your trouble with the embedded
> systems can be solved, we kept separate head.S versions for Macs and other
> machines for a while as well because things just got too confusing. Maybe
> we need to keep separate versions for embedded and other systems here?

Hi All,

  I think we don't want to get too carried away with pulling things
apart here. Afterall I think we'd all like to be able to continue to
pick up a distro with a bootable kernel that works over a wide variety
of machines instead of 10 different kernels to choose from depending on
which box you've got.

  Now obvoiusly I'm going a little overboard here but hopefully you
might see what I'm saying. Granted embedded boxes aren't going to care
about booting from the install cd but I think the rest of us sure do!

--
Hakuna Matata,

Tom

-----------------------------------------------------------
Linux Guy          "My heart is human, my blood is boiling,
tgall@uswest.net    my brain IBM" -- Mr Roboto, Styxx

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
