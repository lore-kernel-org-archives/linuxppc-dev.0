Date: Thu, 8 Jul 2004 18:04:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pawe? Sikora <pluto@pld-linux.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [kernel26@ppc] fixes...
Message-ID: <20040709010446.GM23135@smtp.west.cox.net>
References: <200407070042.56649.pluto@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407070042.56649.pluto@pld-linux.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 07, 2004 at 12:42:56AM +0200, Pawe? Sikora wrote:

> [2] 2.6.7-ppc-cciss-div.patch
> a shift in sector_div() > bit-size of int.
>
> [3] 2.6.7-ppc-ipr-div.patch
> similar sector_div() bug.
>
> [4] 2.6.7-ppc-saa7146-workaround.patch
> is only workaround for a conflict:
>
> "CC [M] ?drivers/media/common/saa7146_video.o
>  drivers/media/common/saa7146_video.c:3: error: conflicting types for `memory'
>  include/asm-m68k/setup.h:365: error: previous declaration of `memory'"
>
> [5] 2.6.7-ppc-strncasecmp.patch
> a confilct with strncasecmp in arch-ppc/lib/strcase.c

All of these should be sent to the respective driver maintainers.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
