Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23638@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Trying to use ELDK to build Ebony/440GP 
Date: Thu, 30 Jan 2003 14:34:30 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Woohoo!!! it works. Thanks to all.

Regarding development trees, penguinppc.org, in its 'kernel sources' link,
refers people to bitmover servers @ either:
  - ppc.bkbits.net or
  - source.mvista.com

What is the "denx ppc development server"? Other than what's available at
ftp.denx.de/pub/LinuxPPC/usr/src, is there an ELDK/denx specific development
tree that I am not yet aware of?

Thanks

-- Brian

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thursday, January 30, 2003 4:59 PM
To: Matt Porter
Cc: brian.auld@adic.com; linuxppc-embedded@lists.linuxppc.org
Subject: Re: Trying to use ELDK to build Ebony/440GP

In message <20030130141657.B25221@home.com> you wrote:
>
> > When I run make zImage, I get the following error message:
>
> > /opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:10:
stdarg.h: No
> > such file or directory
>
> Interesting, it's not picking up stdarg.h from down in the gcc-lib/
> hierarchy.  Probably an ELDK install problem...hopefully Wolfgang
> is reading this thread since he should have a suggestion on what have
> might gone wrong with your installation.

The problem is caused by the modification of kbuild_2_4_nostdinc; see
http://lists.linuxppc.org/linuxppc-embedded/200209/msg00155.html

We reverted this modification in our version of the kernem Makefile.

I don't know if there is a better approach to fix this problem.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
...though his invention worked superbly -- his theory was a crock  of
sewage from beginning to end.         - Vernor Vinge, "The Peace War"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
