Date: Sun, 8 Aug 1999 22:38:24 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Paul.Mackerras@cs.anu.edu.au
cc: mlan@cpu.lu, hedrick@Astro.Dyer.Vanderbilt.Edu, drow@false.org, mj@ucw.cz,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <199908090533.PAA13699@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.96.990808223612.17464J-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Aug 1999, Paul Mackerras wrote:

> David A. Gatwood <dgatwood@mvista.com> wrote:
> 
> > You mean for IDE?  Check the MkLinux driver.  One of Apple's folks ported
> > some OS X (server?) code in for IDE DMA timings a couple months back.
> 
> I saw some code in the macosx driver that looks in the driveid and
> figures it all out - is that what you mean?

I have _no_ idea where in the code the guy found this stuff.  :-)


> I guess I was asking whether there was already some nifty function in
> the Linux kernel that did for DMA modes what ide_get_best_pio_mode
> does for PIO modes.
> 
> Also, do you have a cvsweb server for your cvs repository?  I don't
> want to have to checkout 10s of MB of source just to look at a couple
> of files. :-)  (See http://samba.org/cvs.html if you haven't come
> across cvsweb before.)

I haven't set up CVSweb, but you can just check out a couple of files.
The relevant ones are

osfmk/src/mach_kernel/ppc/POWERMAC/wd.c
osfmk/src/mach_kernel/ppc/POWERMAC/wdreg.h
osfmk/src/mach_kernel/ppc/POWERMAC/wd_entries.h

And you're right, I should set that up....  :-)


Later,
David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
