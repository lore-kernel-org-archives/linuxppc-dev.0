Date: Tue, 28 May 2002 11:35:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] misc compiler warn/err fixes, typo fixes and aesthetic changes
Message-ID: <20020528183509.GI1295@opus.bloom.county>
References: <17983.1022564758@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17983.1022564758@msa.cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 03:45:58PM +1000, Murray Jensen wrote:

> misc compiler warn/err fixes, typo fixes and aesthetic changes

1) Why did you need to add in all of the 'volatile' keyword?  What
compiler are you using which is unhappy with this?  Part of why I ask is
I _think_ this was a problem with gcc-2.96/2.97 but not any actual
'release'.
2) Changes outside of arch/ppc and include/asm-ppc need to go onto
Marcelo (who will either take them or tell you to send them to the
appropriate maintainer).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
