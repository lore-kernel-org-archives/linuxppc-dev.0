Date: Tue, 23 Oct 2001 17:24:56 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org,
	Hollis Blanchard <hollis-lists@austin.rr.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	Martin Costabel <costabel@wanadoo.fr>
Subject: Re: hfs cdrom broken in 2.4.13pre
In-Reply-To: <XFMail.20011023151612.pochini@shiny.it>
Message-ID: <Pine.LNX.4.10.10110231718060.14357-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > One would hope so. All I remember about CDROMs is they use a different
> > blocksize which causes all sorts of funny side effects in generic code
> > that assumes the only sane blocksize is 512.
>
> No. The point is that filesystems should not make assumptions about
> hardware block size (except it being power of 2 I believe). If there
> was code in block layer to provide broken FS's compatibility and that
> code has been removed, then we must fix the FS. Who's HFS maintainer ?

Orphaned I think. But I agree it should be fixed. Using loopback on the
sly doesn't sound a lot cleaner than a reblocking hack in the HFS driver
:-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
