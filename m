Message-ID: <36E2728D.4E3C7D8C@mail.esiea.fr>
Date: Sun, 07 Mar 1999 13:35:29 +0100
From: "G. =?iso-8859-1?Q?Laur=E8s?=" <laures@hp1.esiea.fr>
Reply-To: laures@hp1.esiea.fr
MIME-Version: 1.0
To: Batmensch <hcaley@loomer.com>,
        "Dev @ LinuXppc" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PBG3Series and pre-R5
References: <XFMail.990307023826.hcaley@loomer.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Batmensch a *crit :
>
> Is there a JDK that works on R4?
yes, and it's a killer one (on PBG3292, 3 times faster than the
P200/linux we have at school), see :
http://www.blackdown.org/
http://business.tyler.wm.edu/mklinux/

I ran the fix program on every executables/libs I found in the archive,
but it stll doesn't work in R5.
before, I got segfaults just typing "javac"
now it prints help, but segfaults for compiling the slightest
"hello.java"... still work to be done here, but WITH Xwindows, please,
not before !


> I hope we're taking about the same thing here.  Every once in a while I fire up
> XF68_FBDev as the X server.  I am able to use it, but it is not as stable as
Here it doesn't work at all :

The screen is divided in 4 quarters, both higher quarters contains a
small fvwm screen (each), both lower are black,
the mouse is frozen and it dies quickly.
This is with a bad kernel argument :video=atyfb:vmode:14,cmode:16
(I say bad because atyfb doesn't pop up in the boot sequence, and
XF68_FBDev doesn't sense the aty either)

The screen is white, with somme console text in transparency, the mouse
is working a few seconds, you can activate a pop-up menu (which you can
hardly decipher) and the whole machine is frozen.
This is with video=atyfb,vmode:14,cmode:16 in BootX, which is as (if not
more) bad than the first.
(I say bad because it's not the good syntax for video= with much args,
but at least "atyfb : ATY RAGE LT PRO" etc appears in the boot sequence,
and XF68_FBDev seems to make some use of it)

And stranger even : when atyfb is recognized by the kernel, randomly the
console font changes to a rather gothic one, frezzing all quickly ???!!??

This is all with kernel 2.2.0/2.2.1 from ftp.fr.kernel.org, and now with
a 2.2.2 from samba cvs (a little patched to include volume buttons
functions). I included only both atyfb options in the kernel (plus OFfb
of course).

> Xpmac, and I can't get acceleration to work.  Xpmac is accelerated (and that
> makes quite a difference, so I use it mostly.
I'll try again this one.

I'm quite disappointed since I have the same setup on a 8600, which
works well with XF68_FBDev, in 16bpp.
> >>
> >> Have you been able to get accelerated XFBdev working on yours?
> > no, I'm searching through all archives up to 12/98 to see if I find a
> > solution, so far I got nothing.
> >
> > --
> > GoM
> 
> ----------------------------------
> E-Mail: Batmensch <hcaley@loomer.com>
> Date: 07-Mar-99
> Time: 02:31:13
> 
> This message was sent by XFMail
> ----------------------------------

-- 
GoM

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
