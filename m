From: Joe Green <jgreen@mvista.com>
To: greyham@research.canon.com.au (Graham Stoney),
        linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Subject: Re: Journeyman configure/build options for gcc & glibc?
Date: Wed, 16 Aug 2000 11:44:29 -0700
Content-Type: text/plain
References: <20000815073750.58C33274@elph.research.canon.com.au>
In-Reply-To: <20000815073750.58C33274@elph.research.canon.com.au>
MIME-Version: 1.0
Message-Id: <00081611524600.29732@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 15 Aug 2000, Graham Stoney wrote:
> I thought I had the whole soft-float thing on 8xx worked out long ago, until I
> upgraded our root filesystem to the one from MontaVista's Journeyman kit, and
> found that my glibc-2.1.3.so (which my binaries work when linked against)
> doesn't work in place of the Journeyman glibc-2.1.2.so.  It's the usual
> symptom: A simple floating-point printf gives the wrong answer.
>
> So, my question: what configure options were used to build the gcc-2.95.2 &
> glibc-2.1.2 in Journeyman?  In particular:
>
> - Did the gcc configure include "-with-cpu=860" (or one of the other cpus's
>   to make -msoft-float the default).
>
> - Has the gcc specs file been hacked to pass -D_SOFT_FLOAT in the absence of
>   -mhard-float (note that -mcpu=860 won't do this by default in gcc-2.95.2)
>
> - Was CFLAGS set to include -msoft-float before building glibc?

I believe the compiler has been modified to default to both
-msoft-float and -D_SOFT_FLOAT for ppc_8xx.

> - Any other suggestions :-(

I recall the printf problem as something we specifically fixed.  I
asked the engineer who worked on it, and he said it was a varargs
problem, so the fix is in the the gcc package.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
