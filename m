Date: Thu, 19 Oct 2000 19:47:52 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: Tom Rini <trini@kernel.crashing.org>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Graichen <graichen@innominate.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: openoffice on ppc anyone?
In-Reply-To: <200010191621.LAA28113@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.10.10010191942300.4539-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Well I've run almost every glibc since gary thomas started releasing 'em
> > way back when (thanks gary!) and I've been lucky so far. :)
>
> Me too!  The only real issue for *robust* native threads use are to
> stay with at least with glibc-2.1.3 (glibc-2.1.2 has some problems
> with the jdk).

I'm already convinced, I'll switch as soon as possible. Sometime next
week, hunting for arcane build info has burned more time than I planned to
spend on soffice already. Real world computer desasters took the rest.

> When choosing a glibc-2.1.3 version, stick with either the
> glibc-2.1.3-5a-rpm which shipped with YDL and LinuxPPC I think) from
> Franz or his very latest glibc-2.1.3-15f rpm because the intermediate
> versions had native threads bugs introduced after the glibc-2.1.3
> branch was completed (bug fixes which made new bugs!).

I had got 15d ready to install, thanks for the warning.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
