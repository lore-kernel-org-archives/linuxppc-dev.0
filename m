Date: Tue, 23 Oct 2001 22:08:03 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	Giuliano Pochini <pochini@shiny.it>,
	<linuxppc-dev@lists.linuxppc.org>,
	Hollis Blanchard <hollis-lists@austin.rr.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Martin Costabel <costabel@wanadoo.fr>
Subject: Re: hfs cdrom broken in 2.4.13pre
In-Reply-To: <E15w4ls-0006W5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110232201100.1823-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > By 'it should be fixed' I meant the HFS driver should be fixed to not
> > assume a fixed blocksize.
>
> The block size of the file system is 512 bytes. The block size of the media
> is 2048 bytes. Two totally seperate things

Color me confused... It's clear now, thanks for your patience. Shutting
up, hunting for brown paper bag...

One final concern: your solution means we need (most of) loopback in the
kernel at all times, right? Makes it impossibe to build a kernel without
loopback, or with loopback as a module? Am I missing something still?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
