Subject: Re: proposed patch for cross compiling from Solaris 2.8
From: Jean-Christophe Dubois <jdubois@mc.com>
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.44.0407060823120.2040-100000@spider.ancor.com>
References: <Pine.LNX.4.44.0407060823120.2040-100000@spider.ancor.com>
Content-Type: text/plain
Message-Id: <1089121664.31278.264.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Date: Tue, 06 Jul 2004 15:47:45 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-07-06 at 15:28, Bret Indrelee wrote:
> All of the things you've changed look wrong to me.
>
> Most of your changes are taking out <stdint.h>, which is not correct.
> This header should be on any system, it is part of the C standard.

Sorry but stdint.h is not present on my Solaris 2.8 system. There is
little I can do about this. So maybe Solaris doesn't respect the
standard somewhere but ...

> Even
> the getopt changes shouldn't be required, you should be using the
> version of getopt that came with your package.

Same here getopt.h is not part of solaris headers. Solaris does not seem
to support getopt_long() and getopt() prototype is part of stdio.h,
stdlib.h or unistd.h. But no getopt.h on the horizon ... Should use one
of the other mentioned files.

>
> Are you sure that you've specified -nostdinc -nostdlib and given the
> proper list of locations for the cross-compile system includes when
> compiling?

For what I understand these programs (the ones build from the source I
modified) should not be cross-compiled but build for the host platform
(here Solaris) with the native compiler. Am I wrong?

Oh and I didn't specify any particular -nostdinc -nostdlib flag
anywhere. I am just using the standard Linux 2.6.7 Makefile. The command
used is:

make ARCH=ppc CROSS_COMPILE=powerpc-7400-linux-gnu-

JC

>
> -Bret


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
