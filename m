Date: Mon, 23 Dec 2002 08:12:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions
Message-ID: <20021223151254.GC15397@opus.bloom.county>
References: <20021220010507.E88B6C613A@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021220010507.E88B6C613A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 20, 2002 at 02:05:07AM +0100, Wolfgang Denk wrote:

> It makes the following modifications to the MPC8xx FEC driver:
>
> - change PHY configuration from #define to kernel config mechanism
> - add support for AMD79C874 PHY

Both of these look OK, but can you please split this out into a seperate
patch which just does PHY configuration and then adds AMD79C874 support?

> - add multicast support

Sounds fine, but can you split this portion of the code from the rest of
the patch please?  Thanks.

> - add PACKETHOOK support

This was removed, intentionally back on March 22nd, 2002.  From what I
recall, it was decided this code was broken / unmaintained and should be
yanked.  Have you tested this particular section of code to verify it
still compiles and works as expected?

In sum: On hold for now.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
