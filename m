Date: Tue, 8 Feb 2000 13:40:24 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Ingvar Hagelund; UiO" <ingvar@unik.no>
cc: linuxppc-workstation@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: /dev/fb0 device does not exist
In-Reply-To: <Pine.GSO.4.10.10002081306530.3833-100000@tyr.unik.no>
Message-ID: <Pine.LNX.4.05.10002081338110.27293-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Feb 2000, Ingvar Hagelund; UiO wrote:
> > > When I try to start the fb_dev X-server or try to use the fbset command, I
> > > only get the error
> > > /dev/fb0: No such device
> > >
> > > ls -l /dev/fb0 gives me
> > > crw----rwx   1 ingvar   root      29,   0 Jan 28  2000 /dev/fb0
> > >
> > > so the device file should exist.
> > >
> > > Does this mean my kernel has no support for the frame buffer device?
> >
> > I guess so. What does `cat /proc/fb' tell you? What kind of video hardware do
> > you have?
>
> cat /proc/fb gives:
> cat: /proc/fb: No such file or directory
>
> So, your'e absoloutely right. No kernel support. Looks like I have to
> compile a new kernel.
>
> Anyway, the hardware is a 2MB IBM E15 internal graphics adapter, and
> that's actually a S3 864 based thing. Of course, a real S3 server would be
> the coolest, but I've no success on compiling this so far, though XFree86
> 3.1.2 worked some years ago, I heard.

There's no frame buffer device for the S3 Vision864 yet. So either you have to
help writing that one, or give vga16fb a try (unsupported by XF68_FBDev).

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
