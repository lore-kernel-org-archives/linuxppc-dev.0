Date: Mon, 24 Jul 2000 09:37:03 -0400 (EDT)
From: "Peter R. Wood" <pwood@gordon.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: compiling 2.4.0-test5 -pmu errors
Message-ID: <Pine.LNX.4.21.0007240933360.11526-100000@dyn-133-196.gordon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I'm trying to compile 2.4.0-test5 using the kernel.org sources, and all
compilation seems to go well, up until it tries to link together vmlinux:

arch/ppc/kernel/kernel.o: In function `pmac_set_rtc_time':
arch/ppc/kernel/kernel.o(.text+0x8f48): undefined reference to
`pmu_request'
arch/ppc/kernel/kernel.o(.text+0x8f48): relocation truncated to
fit: R_PPC_REL24 pmu_request
arch/ppc/kernel/kernel.o(.text+0x8f58): undefined reference to `pmu_poll'
arch/ppc/kernel/kernel.o(.text+0x8f58): relocation truncated to
fit: R_PPC_REL24 pmu_poll
make: *** [vmlinux] Error 1

I thought perhaps this meant I should include the PMU adb driver, which
seems silly, since I am using a SuperMac J700, and the PMU is a powerbook
driver... but I went and configured that in, recompiled, and the kernel
linked just fine. However, it hangs on boot.  Why is this required to
compile?  I suppose the hang on boot could be due to some other issue. Any
suggestions?

Thanks,

Peter

--
Peter R. Wood          pwood@gordon.edu
Computer Science       | Lightning    |
Gordon College         | Samurai      |
Wenham, MA             | Action!!!!!! |


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
