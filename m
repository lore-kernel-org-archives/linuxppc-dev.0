From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
Date: Wed, 27 Sep 2000 22:32:29 +0200
Message-Id: <19340822140413.1794@192.168.1.10>
In-Reply-To: 
 <Pine.LNX.4.10.10009272017090.27656-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10009272017090.27656-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Yep, I'm aware of that. I'm way too lazy to backport the PCI resource code
>and the problem seemed solved by using yaboot for me. I didn't
>fully realize the Wallstreet doesn't have this option.
>
>Instead of walking the whole device tree, I hope to get away with just
>picking a free area (assuming pci_dev->base_address[i] == 0 means free)
>instead. But I won't get to it before the weekend. If BenH implements a
>cleaner way, the better.

Well, since this concerns only one machine, in a given configuration, I
beleive it's safe to just hard-code a new mappping we know won't conflict.

How does OF sets up the mapping of the ATI on the Lombard ? Maybe we can
just stuff that in some fixup routine for the wallstreet...

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
