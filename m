Subject: Re: hfs cdrom broken in 2.4.13pre
To: schmitz@zirkon.biophys.uni-duesseldorf.de (Michael Schmitz)
Date: Tue, 23 Oct 2001 16:52:45 +0100 (BST)
Cc: pochini@shiny.it (Giuliano Pochini),
	schmitz@opal.biophys.uni-duesseldorf.de (Michael Schmitz),
	linuxppc-dev@lists.linuxppc.org,
	hollis-lists@austin.rr.com (Hollis Blanchard),
	alan@lxorguk.ukuu.org.uk (Alan Cox),
	trini@kernel.crashing.org (Tom Rini),
	costabel@wanadoo.fr (Martin Costabel)
In-Reply-To: <Pine.LNX.4.10.10110231718060.14357-100000@zirkon.biophys.uni-duesseldorf.de> from "Michael Schmitz" at Oct 23, 2001 05:24:56 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <E15w3rB-0006Bl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > was code in block layer to provide broken FS's compatibility and that
> > code has been removed, then we must fix the FS. Who's HFS maintainer ?
>
> Orphaned I think. But I agree it should be fixed. Using loopback on the
> sly doesn't sound a lot cleaner than a reblocking hack in the HFS driver
> :-)

Believe me it is a lot lot cleaner. It isnt just HFS, its almost all file
systems. If you add a generic reblocking layer it ends up looking remarkably
like the loopback driver

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
