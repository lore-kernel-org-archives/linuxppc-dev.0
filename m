Date: Thu, 20 Jan 2000 19:42:55 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: David Edelsohn <dje@watson.ibm.com>, Moritz Thomas <motho@gmx.net>,
        linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: still no accelerated X ($#!$*)
In-Reply-To: <00012013281100.00851@localhost.localdomain>
Message-ID: <Pine.LNX.4.05.10001201942440.23608-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Jan 2000, Kevin Hendricks wrote:
> > 	One cannot use "r" as a constraint for a base address, that is
> > what the GCC PowerPC port defines "b" for.  The load/store instruction
> > patterns in the GCC PowerPC machine description file use a different
> > constraint letter for the base address, and anyone writing inlined
> > assembly -- especially loads and stores -- should browse the GCC machine
> > description.
>
> Thanks I will as soon as I find it ;-).  But the assembler generated was exactly
> the same in my simple test case.  Is this just luck?

Yes it is.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
