Date: Fri, 11 Feb 2000 18:16:08 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-bk@fsmlabs.com
Subject: Re: Latest OpenPic changes
In-Reply-To: <20000211180524.028896@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.05.10002111815290.356-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 11 Feb 2000, Benjamin Herrenschmidt wrote:
> On Fri, Feb 11, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >and OPENPIC_MASK is still set when the loop times out on enabling
> >IRQ_8259_CASCADE in chrp_init_IRQ(). How is this possible? There's an eieio()
> >after each register write and the mb() does sync.
>
> Is this the only interrupt causing this behaviour ? I beleive that means
> either the mask register is not implemented for the cascade or a hw bug.
> I'll try to have a look at my docs this week-end.

Yes it is. It works fine for all other interrupts (MESH, sym53c8xx).

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
