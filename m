Message-ID: <3FD4B3AF.8020001@jonmasters.org>
Date: Mon, 08 Dec 2003 17:23:59 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: cjohnson@gcctech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: quick survey only for PowerPC 405 folks
References: <3FCE04E3.9080602@gcctech.com>
In-Reply-To: <3FCE04E3.9080602@gcctech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Christopher R. Johnson wrote:

> 1. Kernel version:

Stock 2.4.23 + in house modifications.

> 2. Kernel obtained from:

UK kernel.org official mirror.

> 3. gcc version:

gcc-3.3.2 with some patches.

> 4. glibc version:

glibc-2.3.2 with some patches.

> 5. binutils version:

binutils-2.14.90.0.5

> 6. Did you build your own toolchain?

Yes using the crosstool however prior to that I had a rather painful
experience attempting to build it all up myself based on gcc 2.95
ultimately resulting in deciding DENX had done a better job (they seem
pretty good if you want to buy support too) than I had so...

> 7. If not, where did it come from?

Previously used DENX toolchain which was based upon gcc 2.95.

> 8. What is your development environment (editors, tools, debuggers, etc.)?

Editors - mostly emacs on various platforms with a little vi.
Tools - mostly gnu tools on Powerbook laptop running Debian although
also cross toolchain on Intel GNU/Linux. Xygwin and some Xilinx.
Debuggers - gdb and xmd mostly. Some custom stuff too.

> 9. I have an Abatron, any useful magic I should know?

You can send it to me if you want to :-).

> 10. How do you manage building, configuring and delivering user-mode
> software for the target?

Scripts and some stuff I will automate.

> 11. Please pass along any comments on non-floating point -capable
> processors:

I was recently having problems with soft float on 405D however this
turned out to be a bug in the memory management code which has been
fixed since the release I had originally based my patches upon.
Upgrading seems to have solved that.

Floating point is being done via userspace library emulation however I
am compiling in the soft float support just in case.

Cheers,

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
