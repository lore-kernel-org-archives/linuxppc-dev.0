To: Matt Porter <porter@cox.net>
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Trying to use ELDK to build Ebony/440GP 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 30 Jan 2003 14:16:57 MST."
             <20030130141657.B25221@home.com>
Date: Thu, 30 Jan 2003 22:59:24 +0100
Message-Id: <20030130215929.C31AFC608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030130141657.B25221@home.com> you wrote:
>
> > When I run make zImage, I get the following error message:
>
> > /opt/eldk/usr/src/linuxppc_2_4_devel/include/linux/kernel.h:10: stdarg.h: No
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
