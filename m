From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: khendricks@ivey.uwo.ca, Brad Midgley <brad@turbolinux.com>
Subject: Re: aty128fb does not work in newer sawtooth machines
Date: Sat, 11 Mar 2000 12:22:50 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.20.0003110820530.30663-100000@mail.turbolinux.com> <00031111560300.08663@localhost.localdomain>
In-Reply-To: <00031111560300.08663@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <00031112260400.11535@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Well from the of-device tree I have found out that my graphics card device id
is 0x5046 which equates to a Rage 128 Pro PF card.

Luckily the r128 driver in XFree 4.0 knows about this card and it is not
significantly different from the Rage128 RE card I have in my B+W G3.

I think the whole thing comes down to the default timing info being okay for
Rage128RE but not okay for RAGE128PF

 >  > I looked in aty128fb.c in the kernel
and they hav hardwired defaults which I > can easily change but I need to know
about timing info that Mac OS uses. >  > Do you know of any probe code or
anything at all that can determine timing info > from the MacOS side of things.

I will keep looking.

I am going to add this card to the Xpmac source so that it tries to use its
acceleration code simply on the straight OF frame buffer.  If that works, then
I should be able to use Xpmac to get some of timing info.

Kevin


 >
> >  On Sat, 11 Mar 2000, Brad Midgley wrote:
> > it may be because the video driver is counting on some initialization by
> > macos (bootx).
> > this is the case with aty64 on the g3 laptop. video isn't right if you use
> > yaboot but it's fine with bootx.
>
>
> Thanks,
>
> Kevin
>
> --
> Kevin B. Hendricks
> Associate Professor of Operations and Information Technology
> Richard Ivey School of Business, University of Western Ontario
> London, Ontario  N6A-3K7  CANADA
> khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959
>
>
--

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
