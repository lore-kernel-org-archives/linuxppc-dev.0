From: Miles Lane <miles.lane@comcast.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.0-test2-bk2 (linus' tree) -- arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to `cpufreq_frequency_table_verify'
Date: Sun, 3 Aug 2003 15:15:54 -0700
Cc: linuxppc-dev@lists.linuxppc.org
References: <200308031456.11550.miles.lane@comcast.net> <1059948097.602.1.camel@gaston>
In-Reply-To: <1059948097.602.1.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308031515.54612.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun August 3 2003 3:01 pm, Benjamin Herrenschmidt wrote:
> On Sun, 2003-08-03 at 23:56, Miles Lane wrote:
> > After patching arch/ppc/kernel/setup.c to include cpu.h,
> > I got this error:
> >
> >   LD      .tmp_vmlinux1
> > arch/ppc/platforms/built-in.o(.pmac.text+0x584c): In function
> > `pmac_cpufreq_setup':
> > arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to
> > `cpufreq_frequency_table_verify'
> > arch/ppc/platforms/built-in.o(.pmac.text+0x588c):arch/ppc/platforms/pmac_
> >cpufreq.c:229: undefined reference to `cpufreq_frequency_table_target'
> > arch/ppc/platforms/built-in.o(.pmac.text+0x5930):arch/ppc/platforms/pmac_
> >cpufreq.c:254: undefined reference to `cpufreq_frequency_table_cpuinfo'
> > make: *** [.tmp_vmlinux1] Error 1
>
> That's some Kconfig not up-to-date yet. I'm sorting out various
> missing pmac patches for Linus and will send them over next week,
> including that. You basically need CPU_FREQ_TABLE for now.

Thanks, Ben.  I tried adding "CPU_FREQ_TABLE=y"
and still got the error, though.

	Miles

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
