Date: Tue, 23 Oct 2001 13:26:31 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Hollis Blanchard <hollis-lists@austin.rr.com>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: hfs cdrom broken in 2.4.13pre
In-Reply-To: <3BD54EAD.9F292DAE@wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0110231311010.1680-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Besides - hasn't HFS CDROM support been broken since a long time? Or was
> > that HFS? :-)
>
> There was a slightly more informed discussion about this in August 2000

One would hope so. All I remember about CDROMs is they use a different
blocksize which causes all sorts of funny side effects in generic code
that assumes the only sane blocksize is 512. Not having read l-k since '98
I missed that.

> on the linux-kernel list. The bug was found in the scsi code and fixed
> shortly afterwards by Jens Axboe, IIRC. This was in the good old days

So mounting HFS CDROMs no longer panics? But there's been other reports of
HFS bugs I think. HFS could use a larger overhaul, that might make
integrating HFS+ easier and either do away with the 512 byte blocksize
assumption or hide the conversion inside the HFS driver.
I know nothing about filesystems in general, much less HFS. If there was
another informed discussion on l-k on this topic I'd be happy to know.

> when people thought the upcoming 2.4 kernel series would be stable and
> bleeding-edge development would happen in a 2.5 series.

Ouch.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
