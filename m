Subject: RE: Doing floating point calculations in kernel space
From: Gary Thomas <gary@mlbassoc.com>
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: t.vanremortel@ha.be,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3F710B1D000897FA@mssbzhh-int.msg.bluewin.ch>
References: <3F710B1D000897FA@mssbzhh-int.msg.bluewin.ch>
Content-Type: text/plain
Message-Id: <1066393325.20516.73.camel@hermes>
Mime-Version: 1.0
Date: 17 Oct 2003 06:22:05 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-10-17 at 04:06, Wolfgang Grandegger wrote:
> >-- Original Message --
> >Subject: RE: Doing floating point calculations in kernel space
> >From: Toni Van Remortel <t.vanremortel@ha.be>
> >Reply-To: t.vanremortel@ha.be
> >To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
> >Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
> >Date: Fri, 17 Oct 2003 10:59:29 +0200
> >
> >
> >Op vr 17-10-2003, om 09:52 schreef Toni Van Remortel:
> >> Op vr 17-10-2003, om 09:33 schreef Wolfgang Grandegger:
> >> >  ftp://ftp.denx.de/pub/RTAI/contrib/fp_ppc_8xx.tar.bz2
> >> > It links statically with the libm and the soft-float
> >> > library derived from libgcc.
> >> >
> >> > Hope it's useful.
> >>
> >> Seems useful. Let's check it out deeper and implement it into my module.
> >> I'll keep you informed.
> >
> >It compiles, it runs. Very nice. Thank you a lot for the example. I had
> >only to add the extra linking to my compile command.
>
> Unfortunately, this soft-float implementation from GCC is very
> very slow :-(. I'm just doing some benchmarking with soft-float
> on IBM 405 and compare the result with the soft-float library
> provided by VxWorks. And a simple add (__adddf3) is approx. 5
> times faster on VxWorks. And a look to the assembler code makes
> clear why. Has anybody else on this list made similar experience
> or it there a better free implementation? Has this been improved
> in GCC >= 3.2.
>

A long time ago (circa 1995, when I first started the Linux/PPC
port), Motorola volunteered a very fast floating point library.  I
tested it (in user applications) and found the results to be quite good.
There was never any impetuous to try and put this in the kernel, but
it should work OK.  The [more immediate] problem might be licensing
issues, as IIRC, they didn't want the sources to be public.

Maybe there are some Motorola "lurkers" who could comment.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
