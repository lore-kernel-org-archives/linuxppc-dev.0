Date: Thu, 14 Nov 2002 08:11:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Atm account <linux2@cdotd.ernet.in>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem in booting PPC with kernel 2.5.44
Message-ID: <20021114151136.GB14431@opus.bloom.county>
References: <Pine.OSF.4.10.10209141216080.2765-100000@moon.cdotd.ernet.in> <Pine.OSF.4.10.10211131428120.9066-100000@moon.cdotd.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.OSF.4.10.10211131428120.9066-100000@moon.cdotd.ernet.in>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 13, 2002 at 02:52:59PM +0500, Atm account wrote:

> Hello All,
>   We are porting Linux 2.5.44 for our custom board which has
>  603e processor..
>     We are using the arch/ppc/boot/simple bootloader with minor
> modifications. At the end of boot-code relocation to 8 Mb, the code jumps
> to the relocated code and thereafter
> does the decompression (decompress_kernel)of the vmlinux image to physical
> address 0 and jumps to the 0th location (3 nops followed by code). It is
> from here that early_init is called.

Just wondering, what modifications did you have to make to
arch/ppc/boot/simple?

>     Now the problem is ... the kernel has been linked at 3GB and a call in
> kernel/head.S which says ---

How did you change things to have it link at 3GB?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
