Message-Id: <200010092132.XAA00839@piglet.grunz.lu>
Date: Mon, 9 Oct 2000 23:32:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: can't boot 2.4.0-t9
To: schmitz@opal.biophys.uni-duesseldorf.de
cc: pochini@shiny.it, bh40@calva.net, linuxppc-dev@lists.linuxppc.org,
        pochini@denise.shiny.it, tkanerva@ees2.oulu.fi
In-Reply-To: <Pine.LNX.4.10.10010092018570.30240-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   9 Oct, this message from Michael Schmitz echoed through cyberspace:
> BTW: has the cputemp diff been posted for 2.4 already? If not I'd be happy
> to provide it.

See if it's on sourceforge. If not, put it there.

> There's been some discussion on what CPU clock to use if we
> can't get the clock from OF - is there a max. CPU clock known for such
> machines?

Getting the right clock is absolutely non-critical, only the code blocks
the CPU longer than necessary if the clock is assumed too high.

Other than that, it might be a good idea to just hardcode something like
600 MHz in there for now... We can always change that later if somebody
comes up with a CPU clock detection that always works...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
