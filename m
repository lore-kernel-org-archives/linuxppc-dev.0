Date: Tue, 8 Aug 2000 20:17:05 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
Reply-To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
In-Reply-To: <20000808174916.32452@mailhost.mipsys.com>
Message-ID: <Pine.SOL.3.95.1000808200844.1384E-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Aug 2000, Benjamin Herrenschmidt wrote:
> >
> >I saw a couple of posts from people who seem to have the recent kernels
> >(2.2.17pre1[3-5]-ben1) running on a 1999 Powerbook.
> >Unfortunately, I have still the same problems with the backlight control
> >that first appeared with 2.2.17pre10-ben1, i.e.
> >
> > 1. {Fn-,}F[12] don't adjust brightness
> > 2. After wakeup from sleep, the backlight remains dark
>
> I fixed this recently. I didn't yet post a new precompiled kernel, but I
> will do soon.
> >
I rsync'd last night, but I'll try again this evening.

> >At least it does not seem to crash anymore when I try to repeatedly wake
> >it up, but the only thing I can do at that point is to reboot.
> >Has anyone one of these kernels working on a Lombard and is actually able
> >to use sleep (or adjust monitor brightness)?
> >
> >Besides, the keycodes 10 and 50 (less/greater and asciicircum/degree) on
> >the german keyboard seem to have been swapped in pre13-pre15.
>
> Actually, I think it's more that they are now correct (they used to be
> wrong) ;) You should probably update your keymaps.
>
Must have been wrong for quite a while, but I vaguely recall some problems
with those keys when I first installed Linux (think ^/deg was giving <>
then, and <> did nothing at all, or vice versa).

Thanks,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
