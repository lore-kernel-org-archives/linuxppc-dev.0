Message-ID: <XFMail.20011023151612.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0110231311010.1680-100000@opal.biophys.uni-duesseldorf.de>
Date: Tue, 23 Oct 2001 15:16:12 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: hfs cdrom broken in 2.4.13pre
Cc: linuxppc-dev@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org,
	Hollis Blanchard <hollis-lists@austin.rr.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	Martin Costabel <costabel@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> One would hope so. All I remember about CDROMs is they use a different
> blocksize which causes all sorts of funny side effects in generic code
> that assumes the only sane blocksize is 512.

No. The point is that filesystems should not make assumptions about
hardware block size (except it being power of 2 I believe). If there
was code in block layer to provide broken FS's compatibility and that
code has been removed, then we must fix the FS. Who's HFS maintainer ?

> So mounting HFS CDROMs no longer panics ?

They always worked fine for me.


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
