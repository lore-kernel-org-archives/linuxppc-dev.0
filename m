Date: Sun, 8 Aug 1999 22:18:28 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Paul.Mackerras@cs.anu.edu.au
cc: mlan@cpu.lu, hedrick@Astro.Dyer.Vanderbilt.Edu, drow@false.org, mj@ucw.cz,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <199908090513.PAA09905@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.96.990808221738.17464H-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Aug 1999, Paul Mackerras wrote:

> > I've solved the problem by adding the right offset directly to the
> > io-port values as found in the kernel's PCI structures. I think this
> > needs more serious rework, though. Paul, are you the author of the
> > PowerMac IDE stuff? So we can work this out... 
> 
> Yep, for my sins. :-) :-)
> 
> Also, does anyone know how a quick way to get the best DMA cycle
> timing values in a tuneproc?

You mean for IDE?  Check the MkLinux driver.  One of Apple's folks ported
some OS X (server?) code in for IDE DMA timings a couple months back.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
