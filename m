Date: Wed, 18 Feb 2004 12:03:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rod Boyce <rod_boyce@stratexnet.com>
Cc: Lokesh Kumar <kumar.lokesh@wrx-us.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.6 kernel ppc tree
Message-ID: <20040218190317.GS16881@smtp.west.cox.net>
References: <A3240F62EF3C2749B1A25D3BC9548F41030A01@ExchWENZ02.wenz.global.vpn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A3240F62EF3C2749B1A25D3BC9548F41030A01@ExchWENZ02.wenz.global.vpn>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Feb 18, 2004 at 02:13:21PM +1300, Rod Boyce wrote:

> Wow that was great I got a lot further once I copied the 2.5 kernel uart.c file across.
>
> I had to comment out both referances to ret_from_intercept in the head_8xx.S file I cannot see what is going on there.  I then got to this:
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/ppc/kernel/built-in.o: In function `DoSyscall':
> arch/ppc/kernel/entry.S(.data+0x350): undefined reference to `sys_pciconfig_iobase'
> make: *** [.tmp_vmlinux1] Error 1
>
> I have not more time to spend on this and track down the PCI issues.

That issue in particular has been fixed in later versions.  But
commenting out the ret_from_interrupt lines isn't quite enough to get
the platform booting :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
