Message-ID: <3BD54EAD.9F292DAE@wanadoo.fr>
Date: Tue, 23 Oct 2001 13:04:13 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Hollis Blanchard <hollis-lists@austin.rr.com>,
	Giuliano Pochini <pochini@denise.shiny.it>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: hfs cdrom broken in 2.4.13pre
References: <Pine.LNX.4.33.0110231203080.29506-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> Besides - hasn't HFS CDROM support been broken since a long time? Or was
> that HFS? :-)

There was a slightly more informed discussion about this in August 2000
on the linux-kernel list. The bug was found in the scsi code and fixed
shortly afterwards by Jens Axboe, IIRC. This was in the good old days
when people thought the upcoming 2.4 kernel series would be stable and
bleeding-edge development would happen in a 2.5 series.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
