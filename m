Date: Mon, 9 Oct 2000 20:24:06 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Giuliano Pochini <pochini@shiny.it>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        Giuliano Pochini <pochini@denise.shiny.it>,
        Topi Kanerva <tkanerva@ees2.oulu.fi>
Subject: Re: can't boot 2.4.0-t9
In-Reply-To: <XFMail.001009181549.pochini@shiny.it>
Message-ID: <Pine.LNX.4.10.10010092018570.30240-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > For the X 4 vs. 2.4 issue, I've been biten by this for a long time (on a
> > Pismo too and on a G4) until I figured out that the X server dies when
> > looking up font path.
>
> 4.0.0 works fine here (test7).

4.0.1 runs fine here on -test9, slightly patched to restore adbmouse
function.

BTW: has the cputemp diff been posted for 2.4 already? If not I'd be happy
to provide it. There's been some discussion on what CPU clock to use if we
can't get the clock from OF - is there a max. CPU clock known for such
machines?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
