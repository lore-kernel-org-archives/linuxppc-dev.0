Date: Fri, 25 Jun 1999 10:57:34 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: "Kevin B. Hendricks" <kbhend@business.wm.edu>
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        "Conrad M. Hirano" <placebo2@pobox.com>
Subject: Re: Machine Check in Kernel Mode with Paul's 2.2.10 on B+W G3
In-Reply-To: <v03110702b399351bdfdd@[209.183.128.103]>
Message-ID: <Pine.LNX.3.96.990625105241.20726O-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 25 Jun 1999, Kevin B. Hendricks wrote:

> I know what DMA mode is and how it works, but I don't know what PIO mode

Polled (Programmed) I/O.  It means no DMA and no interrupts.  Just raw
hardware access, complete with the need for predictable timing and
interrupts turned off, generally.  It's really not suitable for anything
beyond testing to see if the drive supports DMA and for early bootstrap
before interupts are turned on.  I would expect a massive performance hit. 
There's a happy medium in there somewhere, though.  It should be possible
to do interrupt driven IDE w/o DMA.  It probably would require a driver
hack, though.

> is?  What impact on MacOS performance will moving the cable have?  Isn't
> DMA mode the fastest way to transfer blocks of data to and from memory?
> Will PIO mode have much of a performance penalty (I have to use this
> machine under MacOS as much or more than I do under LinuxPPC).

I would imagine that the performance impact would be dramatic.  I could be
wrong, though.  The G3 and its busses might be fast enough to not be
horrible at PIO.  No way to know w/o trying it, I suppose.


Later,
David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
