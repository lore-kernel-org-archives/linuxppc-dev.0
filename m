Date: Thu, 28 Mar 2002 17:19:56 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ethan Benson <erbenson@alaska.net>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: DST flag in NVRAM revisited (was: Re: NVRAM stuck in DST?)
In-Reply-To: <20020328040442.V26309@plato.local.lan>
Message-ID: <Pine.GSO.4.21.0203281718540.4979-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 28 Mar 2002, Ethan Benson wrote:
> On Thu, Mar 28, 2002 at 12:28:27PM +0100, Michel Lanners wrote:
> > In arch/ppc/kernel/time.c, kernel time is set from the RTC, implicitly
> > taking RTC for GMT time. Under MacOS, however, it's localtime. On pmac,
> > we use the GMT offset MacOS stores in nvram to correct this, and correct
> > kernel time to real GMT. We also set kernel timezone info, but it's use
> > is discouraged (have a look at man settimeofday).
>
> this is broken.  the kernel should just use the time stored in nvram
> and ignore the crap macos is keeping there regarding time zones.
>
> the solution to the `windows controls the hardware clock' problem was
> made many years ago, hwclock can be told whether the RTC is in
> localtime or GMT, just about every distro asks you this on install (at
> least on x86 debian does on powerpc too).
>
> we should just deal with the RTC exactly how its delt with on x86, if
> you have windows (or in our case MacOS) you tell hwclock the RTC is in
> localtime and let it deal with it, if you don't have MacOS/windows you
> tell it you have the RTC in GMT like its supposed to be and all is well.

Perhaps someone can writes a utility to `patch' MacOS to treat the hardware
clock being in GMT/UTC/Zulu time? I did a similar thing for AmigaOS many many
years ago.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
