Subject: Re: hfs cdrom broken in 2.4.13pre
To: schmitz@zirkon.biophys.uni-duesseldorf.de (Michael Schmitz)
Date: Tue, 23 Oct 2001 17:51:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
	pochini@shiny.it (Giuliano Pochini),
	schmitz@opal.biophys.uni-duesseldorf.de (Michael Schmitz),
	linuxppc-dev@lists.linuxppc.org,
	hollis-lists@austin.rr.com (Hollis Blanchard),
	trini@kernel.crashing.org (Tom Rini),
	costabel@wanadoo.fr (Martin Costabel)
In-Reply-To: <Pine.LNX.4.10.10110231747260.14660-100000@zirkon.biophys.uni-duesseldorf.de> from "Michael Schmitz" at Oct 23, 2001 06:31:10 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <E15w4ls-0006W5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 'almost all file systems' means with respect to CDROM, or in general?
> I can't quite believe something is so fundamentally wrong to affect all
> filesystems...
>
> By 'it should be fixed' I meant the HFS driver should be fixed to not
> assume a fixed blocksize.

The block size of the file system is 512 bytes. The block size of the media
is 2048 bytes. Two totally seperate things

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
