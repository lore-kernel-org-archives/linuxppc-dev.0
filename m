Date: Wed, 24 Oct 2001 09:21:19 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Giuliano Pochini <pochini@shiny.it>, linuxppc-dev@lists.linuxppc.org,
	Hollis Blanchard <hollis-lists@austin.rr.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Martin Costabel <costabel@wanadoo.fr>
Subject: Re: hfs cdrom broken in 2.4.13pre
In-Reply-To: <E15w8U2-0000yo-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10110240916230.17136-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > kernel at all times, right? Makes it impossibe to build a kernel without
> > loopback, or with loopback as a module? Am I missing something still?
>
> You would need loopback in kernel or as a module. That isnt a big problem

And whatever your root filesystem, it better not rely on loopback for any
blocksize mangling. That's what I'm queasy about, mostly (plus the option
to build kernels without any loopback support, in case anyone wants that).

I'm sure that's been hashed out in excruciating detail, and someone's
thought of it.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
