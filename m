Date: Tue, 23 Oct 2001 12:08:04 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Hollis Blanchard <hollis-lists@austin.rr.com>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: hfs cdrom broken in 2.4.13pre
In-Reply-To: <20011022155617.B6673@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0110231203080.29506-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > >> The last kernel I'm sure it worked fine is 2.4.7
> > > >
> > > > Mount it over loopback device.
> > >
> > > Why has that become necessary?
> >
> > Primarily because the glue in the middle isnt covering up for your CD-ROM
> > any more.
>
> No, really.  What's changed to break HFS cdrom support?

The cdcom code no longer permitting to fake a nonstandard block size? The
blocksize on CDs is always 2k IIRC, the HFS driver just can't cope with
that.

Besides - hasn't HFS CDROM support been broken since a long time? Or was
that HFS? :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
