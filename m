Date: Mon, 9 Aug 1999 15:33:41 +1000
Message-Id: <199908090533.PAA13699@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: dgatwood@mvista.com
CC: mlan@cpu.lu, hedrick@Astro.Dyer.Vanderbilt.Edu, drow@false.org, mj@ucw.cz,
        linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.96.990808221738.17464H-100000@mvista.com>
	(dgatwood@mvista.com)
Subject: Re: Trying a Promise Ultra/66 on powerpc
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.96.990808221738.17464H-100000@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David A. Gatwood <dgatwood@mvista.com> wrote:

> You mean for IDE?  Check the MkLinux driver.  One of Apple's folks ported
> some OS X (server?) code in for IDE DMA timings a couple months back.

I saw some code in the macosx driver that looks in the driveid and
figures it all out - is that what you mean?

I guess I was asking whether there was already some nifty function in
the Linux kernel that did for DMA modes what ide_get_best_pio_mode
does for PIO modes.

Also, do you have a cvsweb server for your cvs repository?  I don't
want to have to checkout 10s of MB of source just to look at a couple
of files. :-)  (See http://samba.org/cvs.html if you haven't come
across cvsweb before.)

Regards,
Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
