Date: Wed, 31 Jan 2001 08:10:45 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
cc: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
In-Reply-To: <Pine.LNX.4.10.10101302239070.27612-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.05.10101310808540.30092-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 30 Jan 2001, Michael Schmitz wrote:
> > So the only points in common seem to be that the DVD drives are running
> > on mac hardware and that the drivers are written by Paul Mackerras.  :-)
> > I don't at all mean to impugn Paul's coding ability, which is obviously
> > excellent, but the fact that he wrote both the drivers may mean that
> > they share lots of code and possibly share the same bug.
>
> If so, the bug should have propagated to the m68k 53c9x driver. Wouldn't
> be the 53c9x first weirdness - I never got it to accept a DAT drive (old
> DDS-1, possibly Apple) without blowing up.

FYI, my DDS-1 worked with my MESH. Not perfectly, sometimes it gave a warning
(lost arbitration, IIRC), which aborted the current reading/writing.

Moving the DD-1 to the Sym53c875 solved the problem.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
