To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: Mac-on-Linux
References: <19990519235050.60265@ibrium.se> <Pine.LNX.3.96.990519210752.5706A-100000@EdMcMan.Dyn.Ez-Ip.Net> <19990520192459.17170@ibrium.se> <19990520171823.A409@jasons.dyn.kpn.cx> <87zp2ysaku.fsf@hades.nocrew.net> <19990521203719.44590@ibrium.se>
Content-Type: text/plain; charset=US-ASCII
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 21 May 1999 22:19:34 +0200
In-Reply-To: Samuel Rydh's message of "Fri, 21 May 1999 20:37:19 +0200"
Message-ID: <87so8qp44p.fsf@hades.nocrew.net>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Samuel Rydh <samuel@ibrium.se> writes:

> Thanks for the testing! My directions were bad though.
> I missed the fact that the kernel source uses #ifdef 
> and not #if, so the line
> 
> #define NO_RELOAD_HTAB 1
> 
> should be commented out in 'arch/ppc/kernel/head.S' and
> 'arch/ppc/mm/init.c'.
> 
> I've looked through the Mac-on-Linux kernel source, and I 
> think this should be sufficient to add support for the 603.
> (There is a 603 incompatible function used by the debugger, 
> but I don't think it is used normally.)

Ok.. this seems to help a lot. It no longer panics, and I've
got a rom-image for my performa 6400, but when I tell it to
start with Meta-G, it just sits there.

This machine has a valkyrie graphics card, and since 
platinum seems to be more or less the only thing supported,
I can guess that's why I don't see anything.

Is that why? :)

Anyway.. it exits when I press Ctrl-C, so the machine is
alive and all.

One step in the right direction :)

/Stefan

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
