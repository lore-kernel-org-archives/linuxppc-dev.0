Message-ID: <37949060.878FF791@generation.net>
Date: Tue, 20 Jul 1999 11:06:08 -0400
From: Simon Piette <spiette@generation.net>
MIME-Version: 1.0
To: puetzk6715@uni.edu, LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: X : caught signal 11 ?
References: <Pine.PMDF.3.96.990720092348.538970380F-100000@uni.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


puetzk6715@uni.edu wrote:

> > On Tue, 20 Jul 1999, Yann Bizeul wrote:
> > >
> > > I've a little bit more informations.
> > > 1) X caught signal 11 and quits each time I go back to a console.
> > > 2) X quits each time XScreensaver is launching
> > >
> > > Iuse the XFree server provided by Release 5
> >
> > I also have problem 1), though I guess I've managed to disable xscreensaver so
> > X does its built-in blanking thing (with no power saving =( ).
> >

I have problem 2), but when I'm disabling xscreensaver! I'm using R5 (final) on
UMAX J700 with an IMS TwinTurbo 128 (2 Mb VRAM) . Power saving does not work in
either ways.

BTW, is anybody knows which arguments to give (for BootX) if I want to remove the
"No video driver" options? I've tried a few combinations (like
video=imsttfb:vmode:17,cmode:16), but even the console is almost unusable. I think
that the only to use the IMS is to check that "No video driver" option.

Simon Piette


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
