From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Jeffrey Hawkins <Jeffrey.F.Hawkins@motorola.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: do md5sums differ across architectures?
Date: Thu, 22 Feb 2001 17:12:47 -0500
Content-Type: text/plain;
  charset="us-ascii"
References: <200102221857.f1MIvW706290@ashley.ivey.uwo.ca> <3A9571F2.4751730C@motorola.com> <01022216133800.04317@localhost>
In-Reply-To: <01022216133800.04317@localhost>
MIME-Version: 1.0
Message-Id: <01022217124700.04392@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I upgraded my Solaris 7 to the gnu 2.0 version and now it matches ppc linux
completely.

That still leaves MacOSX out in the cold but...

Thanks for the hint.

Kevin

On Thursday 22 February 2001 16:13, Kevin B. Hendricks wrote:
> Hi,
>
> Here is what md5sum --version says on my machine.
>
> [kbhend@localhost kbhend]$ md5sum --version
> md5sum (GNU textutils) 2.0e
> Written by Ulrich Drepper.
>
> Copyright (C) 1999 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> [kbhend@localhost kbhend]$
>
>
> This appears to be newer that yours.  I will upgrade textutils again on both
> my box and the solaris 7 box.  Hopefully eventually they will coincide.
>
> I still don't know why MacOSX differs from both.  I thought it would match
> one or the other so that I knew which one to upgrade.
>
> Thanks,
>
> Kevin
>
>
> On Thursday 22 February 2001 15:09, Jeffrey Hawkins wrote:
> > Kevin,
> >
> >
> > Don't know what is going on with your md5sum, but
> > I ran it on a LinuxPPC 2.2.17 System and a SunOS 5.6,
> > and got the same results ??????  The version of md5sum
> > on Linux was 1.22, and the version on Sun was 2.0.
> >
> >
> > Jeff
> >
> > ,"Kevin B. Hendricks" wrote:
> > >
> > > Hi,
> > >
> > > Just to have a bit of fun, how about this (3 different systems)
> > > Each generates a different md5sum but all generate the same cksum!
> > > (and adding -b to md5sum makes no difference)
> > >
> > > Darwin khendricksmac 1.2 Darwin Kernel Version 1.2: Wed Aug 30 23:32:53
> PDT 2000; root:xnu/xnu-103.obj~1/RELEASE_PPC  Power Macintosh powerpc
> > >
> > > [khendricksmac:~] kbhend% md5sum oo619b_src.tar.bz2
> > > 9c6a44ad66572c834e282eb1ec665374  oo619b_src.tar.bz2
> > > [khendricksmac:~] kbhend% cksum oo619b_src.tar.bz2
> > > 2458761606 56057947 oo619b_src.tar.bz2
> > >
> > > SunOS crunch 5.7 Generic_106541-04 sun4u sparc SUNW,Ultra-250
> > >
> > > kbhend$ md5sum oo619b_src.tar.bz2
> > > 278c21a764126027cba9cb685b7e96cf  oo619b_src.tar.bz2
> > > kbhend$ cksum oo619b_src.tar.bz2
> > > 2458761606      56057947        oo619b_src.tar.bz2
> > >
> > > Linux localhost 2.2.17pre10-ben2 #3 Sun Aug 13 13:03:45 EDT 2000 ppc
> unknown
> > >
> > > [kbhend@localhost /src2]$ md5sum oo619b_src.tar.bz2
> > > c4a5d7bda6973f6b56e725295d1b3dfb  oo619b_src.tar.bz2
> > > [kbhend@localhost /src2]$ cksum oo619b_src.tar.bz2
> > > 2458761606 56057947 oo619b_src.tar.bz2
> > >
> > > I guess md5sum is not a very reliable or consistent checksum measure for
> moving
> > > files between ppc linux, MacOSX, and Solaris 7 Sparc.
> > >
> > > Back to the old cksum for me.
> > >
> > > Kevin
> > >
> >
> > --
> > ************************************************
> >
> > Jeffrey Hawkins
> > Senior Staff Software Engineer
> > Motorola Wireless Data Solutions Engineering
> >
> > Address: DEPT:  DQ525
> >          MS:    IL-02-1055A              .-.
> >          1301 East Algonquin Road        /v\
> >          Schaumburg, IL 60196           // \\
> >                                        /(   )\
> > Phone:   (847)576-7463                  ^^ ^^
> > FAX:     (847)576-7737
> >
> > ************************************************
> >
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
