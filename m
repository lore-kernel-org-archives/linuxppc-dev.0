Subject: Re: 2.6.0-test2-bk2 (linus' tree) --
	arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to
	`cpufreq_frequency_table_verify'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308031456.11550.miles.lane@comcast.net>
References: <200308031456.11550.miles.lane@comcast.net>
Content-Type: text/plain
Message-Id: <1059948097.602.1.camel@gaston>
Mime-Version: 1.0
Date: 04 Aug 2003 00:01:38 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-03 at 23:56, Miles Lane wrote:
> After patching arch/ppc/kernel/setup.c to include cpu.h,
> I got this error:
>
>   LD      .tmp_vmlinux1
> arch/ppc/platforms/built-in.o(.pmac.text+0x584c): In function
> `pmac_cpufreq_setup':
> arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to
> `cpufreq_frequency_table_verify'
> arch/ppc/platforms/built-in.o(.pmac.text+0x588c):arch/ppc/platforms/pmac_cpufreq.c:229:
> undefined reference to `cpufreq_frequency_table_target'
> arch/ppc/platforms/built-in.o(.pmac.text+0x5930):arch/ppc/platforms/pmac_cpufreq.c:254:
> undefined reference to `cpufreq_frequency_table_cpuinfo'
> make: *** [.tmp_vmlinux1] Error 1

That's some Kconfig not up-to-date yet. I'm sorting out various
missing pmac patches for Linus and will send them over next week,
including that. You basically need CPU_FREQ_TABLE for now.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
