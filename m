Subject: Re: hfs cdrom broken in 2.4.13pre
To: schmitz@opal.biophys.uni-duesseldorf.de (Michael Schmitz)
Date: Tue, 23 Oct 2001 21:49:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
	schmitz@zirkon.biophys.uni-duesseldorf.de (Michael Schmitz),
	pochini@shiny.it (Giuliano Pochini), linuxppc-dev@lists.linuxppc.org,
	hollis-lists@austin.rr.com (Hollis Blanchard),
	trini@kernel.crashing.org (Tom Rini),
	costabel@wanadoo.fr (Martin Costabel)
In-Reply-To: <Pine.LNX.4.33.0110232201100.1823-100000@opal.biophys.uni-duesseldorf.de> from "Michael Schmitz" at Oct 23, 2001 10:08:03 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <E15w8U2-0000yo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> kernel at all times, right? Makes it impossibe to build a kernel without
> loopback, or with loopback as a module? Am I missing something still?

You would need loopback in kernel or as a module. That isnt a big problem
in the sense that its no bigger than internal glue to do the job and in
fact is pretty small anyway (about 8K)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
