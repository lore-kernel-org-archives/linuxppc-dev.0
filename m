Date: Wed, 8 Mar 2000 20:12:10 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Grant Erickson <grant@borg.umn.edu>
cc: Michel Lanners <mlan@cpu.lu>, Matt Porter <mmporter@home.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Grabbing an Interrupt for a Brain-dead PCI Device
In-Reply-To: <Pine.SGI.4.21.0003081136360.51665-100000@brule.borg.umn.edu>
Message-ID: <Pine.LNX.4.05.10003082011320.8208-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 8 Mar 2000, Grant Erickson wrote:
> Also, regarding memory address space resources, is there a routine I can
> call that says "Assign this card some resource space because it hasn't
> been assigned one yet"?

Yes there is, somewhere in drivers/pci/. I don't know yet whether it works.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
