Message-ID: <3817396D.51DC81CA@andrew.cmu.edu>
Date: Wed, 27 Oct 1999 13:42:05 -0400
From: Hollis R Blanchard <hollis@andrew.cmu.edu>
MIME-Version: 1.0
To: alex khalil <alex@leb.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: B/W G3 ATY 128 vram not recognized
References: <19991027123206.A5039@leb.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


alex khalil wrote:
> 
> Hello
> 
>   This B/W G3 displays only 614k of VRAM which allows it 640x480 in
> 16 bits.
>   The video card is an ATY 128.
> 
>   How to make the rest of the VRAM appear in Xconfigurator.
> 
>   I used kernel 2.2.10 rev2 for B/W G3, XF86_FBDev 3.3.5, and otherwise
> LinuxPPC 5 with the set of security updates from linuxppc.org

If you have BootX's "no video driver" checked, Xconfigurator will not be
able to correctly detect your VRAM.

Xconfigurator frequently doesn't work right anyways, in which case I'd
suggest Xautoconfig.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
