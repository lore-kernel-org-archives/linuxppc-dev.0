Date: Tue, 19 Feb 2002 09:11:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Gerard Basler <gbasler@ee.ethz.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Missing "#ifdef" in arch/ppc/boot/simple/mics-embedded.c ?
Message-ID: <20020219161155.GA4739@opus.bloom.county>
References: <Pine.GSO.4.43.0202191043500.13185-100000@tardis-b01.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.43.0202191043500.13185-100000@tardis-b01.ee.ethz.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 19, 2002 at 11:27:40AM +0100, Gerard Basler wrote:

> I don?t have any experience with embedded-linux and I had a while
> until I managed to compile the Kernel for a PPC405GP Walnut
> architecture.
> I always received a compile error in
> arch/ppc/boot/simple/misc-embedded.c
> saying that the function "serial_close" (line 228) wasn?t found.
> I looked at line 84:

IIRC, a few months back, compiling w/o CONFIG_SERIAL_CONSOLE wouldn't
even link the kernel.  If it's going that far now, I'll go and apply
what you said later today (it is correct, btw).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
