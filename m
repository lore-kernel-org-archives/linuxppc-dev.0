Date: Mon, 13 Mar 2000 11:19:30 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Help! Getting aty128fb.c to work with newest sawtooth machines
In-Reply-To: <00031109361000.07471@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0003131025250.734-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 11 Mar 2000, Kevin Hendricks wrote:

> Hi Kostas,
>
> If just received a G4 450 but if I try to use aty128fb.c in any resolution
> higher than 1024x768 8bpp it will fail miserably with the screen split into 3
> vertical panes.
>
> If I try blindly launching xf 4.0 r128, it inherits the fb mode and I end up
> with 3 panes as well.
>
> This is obviously a aty128fb.c problem since it occurs in the console.
>
> I looked at Anthony's code (remember the problem I had earlier when he tried to
> read values for the dotclock and xclk out of the of device tree?) and then used
> lsprop to print out the graphics card info.
>
> Unfortunately, there were no nice of-tree variables in my G4 tree at all but it
> did report my card as a Rage128Pro and not a simple Rage128.
>
> Is a Rage128Pro different from a Rage128 when it comes to setting it up,
> register usage, etc or is this simply a problem with the default timings
> setting being incorrect for this card?
>

  Rage128Pro should be the same as Rage128, so its possible that its a
timing issue. We need to find a way to get the correct values for ppc,
i wonder if the OF rom has any info we can use.

> Interestingly enough, I can boot with aty128fb with 1024x768 and 8bpp and the
> console is fine (no 3 panes) and I can then successfully start up XFree4.0 with
> r128 acceleration so things do appear to be working under some cases.
>
> Is there any tool (code piece, etc) I can use to probe the timing info as used
> under MacOS?
>

 Ben's ATIGrab (http://ppclinux.apple.com/~benh/ATIGrab.sit) utility might
help you there, the source is included there and it shouldn't be hard to
modify it to get it working for rage128.

> Thanks,
>
> Kevin
>

  Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
