Date: Fri, 6 Jun 2003 08:38:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Wrong BAT mapping message in dmesg
In-Reply-To: <ECE5A6A9-9733-11D7-ABA8-00039394E428@ees.hokudai.ac.jp>
Message-ID: <Pine.GSO.4.21.0306060837351.864-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 5 Jun 2003, Etsushi Kato wrote:
> On 2003.6.5, at 04:32  PM, Benjamin Herrenschmidt wrote:
> >> I recently created Linux-2.4 for NuBus PowerMac repository with
> >> bitkeeper.  If anyone has interested in this, please look at
> >> http://nubus-pmac.bkbits.net/.  This nubus tree is originally derived
> >> from Takashi Oe's 2.4.6-pre3 patch, and I've maintained since
> >> 2.4.19-something.
> >
> > Ah great. I was wondering what was the status. What about 2.5 ? Do
> > you have any intend to go there ?
>
> It is based on linuxppc_2_4 stable tree (now 2.4.21-rc7), and it is
> quite stable on both PPC601 PowerMacs (6/7/8100) and PPC603(e)
> Performa.  I think nubus patch doesn't cause any big problem on normal
> PowerMac since vmlinux made from the nubus tree works fine on my old
> PCI PowerMac (UMAX C500), but not yet checked in great detail.  One
> thing I haven't port current linuxppc_2_4 code to NuBus is idle_6xx.S.
> NuBus kernel still use old power_save().
>
>
> Porting of kernel 2.5 doesn't occur yet.  Nobody on linuxppc-nubus
> mailing list started yet.  But I just tested 2.5.70 on my old UMAX C500
> and confirmed to work on PPC603ev machine today (although valkyriefb.c
> is needed to fix a little bit),  So I'll try to port 2.5 to NuBus
> PowerMac in some extra time.

Do you have any more drivers or driver fixes that are important for Mac/m68k
users as well (both 2.4.x and 2.5.x)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
