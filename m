Date: Tue, 23 Oct 2001 18:31:10 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Giuliano Pochini <pochini@shiny.it>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org,
	Hollis Blanchard <hollis-lists@austin.rr.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Martin Costabel <costabel@wanadoo.fr>
Subject: Re: hfs cdrom broken in 2.4.13pre
In-Reply-To: <E15w3rB-0006Bl-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10110231747260.14660-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Orphaned I think. But I agree it should be fixed. Using loopback on the
> > sly doesn't sound a lot cleaner than a reblocking hack in the HFS driver
> > :-)
>
> Believe me it is a lot lot cleaner. It isnt just HFS, its almost all file
> systems. If you add a generic reblocking layer it ends up looking remarkably
> like the loopback driver

'almost all file systems' means with respect to CDROM, or in general?
I can't quite believe something is so fundamentally wrong to affect all
filesystems...

By 'it should be fixed' I meant the HFS driver should be fixed to not
assume a fixed blocksize.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
