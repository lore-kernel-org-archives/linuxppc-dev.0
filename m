Date: Mon, 13 Mar 2000 18:34:16 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org,
        Kevin Puetz <puetzk@iastate.edu>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to workonppcwithr128
In-Reply-To: <38CCF340.363C70A7@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.10.10003131805200.6096-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > xfree init mode:        64902   1024 1064 1200 1344   768 771 777 806
> > fbdev init mode:        15407   1024 40 136 144   768 3 6 29   16 0:0:0
> >
> > with the only thing that seems fishy the 0:0:0 as the res:blue:green
> > length values.
>
> If it's for 16 bpp, this might be the problem.
>
> Have you tried with several depths? (15, 8, 24, 32, ???)

I've tried 8, 16 and 32 so far; with 32, already X -probeonly fails. Just
tried 24 and it also fails ...

Ignoring (and not fixing) the PCI conflicts gets noticed by the server
and makes probe/start fail. Back to the drawing board.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
