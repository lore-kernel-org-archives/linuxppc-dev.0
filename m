Date: Wed, 8 Mar 2000 11:10:57 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: enneper@gmx.net
cc: Robert Shaw <rshawppc@netscape.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Booting 2.3.48 (devel) kernel problems?
In-Reply-To: <20000308082541.A782@gmx.li>
Message-ID: <Pine.LNX.4.10.10003080937390.10214-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  Robert Shaw }  I have a PowerBook G3 (1997) that I'm trying to get the latest devel kernel
>  Robert Shaw }  compiled and booting on (2.3.48). However, no matter what I try, it always
>  Robert Shaw }  hangs at the "booting..." screen.
> probably CONFIG_DEVFS_FS = y ????
> first try /usr/scr/linux/Documentation/filesystems/devfs/README

That, plus a few patches related to BootX text console output happening
before the framebuffer is mapped. I'll dig out a patch if necessary.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
