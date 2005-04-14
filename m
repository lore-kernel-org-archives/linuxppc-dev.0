Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 728E867B59
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 15:49:18 +1000 (EST)
To: larry_chen@agilent.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 13 Apr 2005 16:35:36 MDT."
	<26F517960E0A454BAC0748B5C33D5DEA18A722@wcosmb05.cos.agilent.com>
Date: Thu, 14 Apr 2005 07:48:43 +0200
Sender: wd@denx.de
Message-Id: <20050414054848.98881C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK 3.1.1 support for x86_64 host architecture 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <26F517960E0A454BAC0748B5C33D5DEA18A722@wcosmb05.cos.agilent.com> you wrote:
> 
> I've noticed that the ELDK build and install scripts do NOT
> support x86_64 host architecture.

Which sort of host system is this (Processor(s), RAM, Linux distribution) ?

> What support for x86_64 host architecture ever attempted
> by anyone?

It works fine here on several Athlon / Opteron systems running Fedora
Core 2 and Fedora Core 3; for example:

-> cat /etc/issue
Fedora Core release 2 (Tettnang)
Kernel \r on an \m

-> uname -a
Linux pollux 2.6.10-1.770_FC2smp #1 SMP Sat Feb 26 19:46:59 EST 2005 x86_64 x86_64 x86_64 GNU/Linux
-> cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 2004.596
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 3940.35
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 246
stepping        : 10
cpu MHz         : 2004.596
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 4005.88
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

-> type ppc_8xx-gcc
ppc_8xx-gcc is /opt/eldk/usr/bin/ppc_8xx-gcc
-> ppc_8xx-gcc -v
Reading specs from /opt/eldk-3.1.1/usr/bin/../lib/gcc-lib/ppc-linux/3.3.3/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --with-newlib --enable-languages=c,c++ --disable-libgcj --host=i386-redhat-linux --target=ppc-linux
Thread model: posix
gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9)


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Neckties strangle clear thinking.                       -- Lin Yutang
