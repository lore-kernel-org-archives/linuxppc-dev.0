To: linuxppc-dev@lists.linuxppc.org
Subject: Re: SMP G4, BK 2.4.1, aty128, and 22" Apple Cinema Display (ADC)
References: <20010131162641.A11495@troy.psych.nwu.edu>
	<3A78943C.D795ABD8@iiic.ethz.ch>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 01 Feb 2001 10:37:31 +0100
In-Reply-To: Michel Dänzer's message of Wed, 31 Jan 2001 23:39:56 +0100
Message-ID: <8xg0hywxpg.fsf@s62.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer <michdaen@iiic.ethz.ch> writes:

>
>
> T E Whalen wrote:
> >
> > I'm running Debian (testing) on the above configuration.  I'm trying to
> > get XFree 4.0.2 to work.  Right now, I can boot with the "novideo"
> > option, and XFree 3.3.6 will work in 1600x1200@8bpp.
>
> [snip]
>
> > fbset says:
> > mode "1600x1024-57"
>
> I thought you wanted 1600x1200, can you try fbset 1600x1200-60 ? Dunno if
> aty128fb supports that mode on bootup, in doubt check the source.
>
The LCD panel inside the Cinema Display only understands a single mode:
1600x1024 at 59.94 Hz, with a dot clock of 107.24 MHz. Olaf Hering added
the vmode 22 according to a spec sheet I found somwehere on the 'net. I
am using a Cinema Display with a patched 2.2.18 kernel in said mode; it
does work at least for me. So far I tried neither XFree 4.x nor any
2.4 kernel.

  Holger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
