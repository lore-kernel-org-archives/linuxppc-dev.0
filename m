Date: Wed, 7 Mar 2001 13:32:57 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sym53c875 in 2.4.2
In-Reply-To: <19350125130851.8098@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.05.10103071330410.773-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2 Mar 2001, Benjamin Herrenschmidt wrote:
> >I just tried the current bk linuxppc_2_4 on my CHRP LongTrail with Sym53c875
> >card. The Sym53c8xx driver fails downloading the SCSI scripts, and keeps
> >trying
> >ad infinitum.
> >
> >At first sight, the kernel seems to work when I disable the Sym53c8xx driver
> >with `sym53c8xx=excl:0x1400'. It boots to a shell from the MESH.
> >
> >PCI seems to be OK. Only changes are that the sl82c105 IDE got assigned some
> >I/O ports now.
> >
> >Everything worked fine in the 2.4.1 from a month ago.
>
> Are there any conflicting assignements ? Could you check if the new
> phys_to_bus() function returns proper values (finds the bus on which
> the Sym chip resides) ?

My hose resources were not set up, so phys_to_bus() returned NULL. Wouldn't it
be better to return pa in that case, or at least print an error to the console?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
