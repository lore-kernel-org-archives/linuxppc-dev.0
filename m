Date: Mon, 21 Aug 2000 13:33:04 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org, dmj+@andrew.cmu.edu
Subject: Re: Control fb problem on 8500
In-Reply-To: <39A0EF0C.EDC3D3A1@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10008211331570.11699-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > It does support that, if not directly then certainly via shadowfb. Maybe the
> > shadowfb RefreshArea function would have to be modified to take account of
> > this.
>
> That's not even needed, the fbdev driver is just broken. Line 430:
>
> 	pScrn->displayWidth = pScrn->virtualX; /* FIXME: might be wrong */
>
> is indeed wrong. virtualX is obvious, but displayWidth should be the memory
> pitch of a scanline.

That would indeed be silly.

> Now you just have to find out where to get the correct value for displayWidth.

Something like xres*bpp/8 ??

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
