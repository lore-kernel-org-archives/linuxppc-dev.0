Date: Tue, 4 Dec 2001 17:20:56 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Max swap size ?
In-Reply-To: <1007482452.21511.10.camel@pismo>
Message-ID: <Pine.GSO.4.21.0112041718470.15617-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 4 Dec 2001, Michel [ISO-8859-1] Dänzer wrote:
> On Tue, 2001-12-04 at 00:04, Christopher Murtagh wrote:
> >  I have a machine running YDL (Dual 800Mhz, 1GB RAM) with a 2.4.13 SMP
> > kernel (YellowDog's stock SMP kernel) that has a 512 MB swap partition.
> > When I tried to install on other machines, they wouldn't boot with a swap
> > partition that big, but for some reason this one did. It wasn't until
> > after the other machines wouldn't boot did I notice in the TerraSoft docs
> > that 256MB was the max.
>
> That used to be the case before kernel 2.2 IIRC. Nowadays the limit is
> in the gigabytes. FWIW I'm using a 400 meg swap partition without
> problems.

The limit used to be 128 MiB, not 256 MiB. They used one page as a bitmask to
mark swap pages that were in use, hence 4096*8*4kiB = 128 MiB.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
