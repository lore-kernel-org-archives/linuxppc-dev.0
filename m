Date: Thu, 14 Nov 2002 10:48:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Magnus Damm <damm@opensource.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bi_record and initrd
Message-ID: <20021114174807.GC605@opus.bloom.county>
References: <3DD3C747.8B7EE5CD@opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DD3C747.8B7EE5CD@opensource.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 14, 2002 at 04:54:47PM +0100, Magnus Damm wrote:

> The bi_record setup code in linux/arch/ppc/boot/simple/misc-embedded.c
> doesn't care about the initrd size. So, if you are using a initrd that
> crosses a megabyte-boundary you will have your initrd overwritten with
> the bi_record. This results in crc error when unpacking the initrd.
>
> The quick fix is to add a offset to the boot-code and to
> arch/ppc/kernel/setup.c.
>
> So, what's the long term solution?
> Passing a pointer to the kernel?

Can you give more information about where everything is loaded up at?  I
thought this was a non-issue, but it's been a while since I tested
initrds.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
