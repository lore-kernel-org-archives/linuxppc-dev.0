Date: Sun, 27 Dec 1998 12:59:32 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: "Jens Ch. Restemeier" <jenschrr@post.uni-bielefeld.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: egcs bug  - who can I send it to ?
In-Reply-To: <36862FB3.17B2@post.uni-bielefeld.de>
Message-ID: <Pine.LNX.3.96L.981227125743.1898A-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 27 Dec 1998, Jens Ch. Restemeier wrote:
> 
> I've got a problem compiling the latest snapshot of crystal space on
> Linux/PPC. The same archive compiles on my 486 (after some small fixes).
> 
> The RPMS I installed didn't have a "mail me for bugs" address.
> 
> Is this a known bug ?
> 
> util/gfx/gifimage.cpp: In method `ImageGifFile::ImageGifFile(UByte *,
> long int)':
> util/gfx/gifimage.cpp:383: internal error--unrecognizable insn:
> (insn 3958 3955 54 (set (mem:SI (plus:SI (reg:SI 18 r18)
>                 (const_int 65536)))
>         (reg:SI 19 r19)) -1 (insn_list 3621 (insn_list 3955 (nil)))
>     (nil))
> toplev.c:1360: Internal compiler error in function fatal_insn
> make[1]: *** [out/LINUX/X11_o/util/gfx/gifimage.o] Error 1
> make: *** [cs] Error 2

I think "internal compiler errors" are usually due to an optimization setting
that's to high. Look for a -O switch in your Makefile, and set it to 2 or
below (-O2, -O1, or -O0).

-Hollis


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
