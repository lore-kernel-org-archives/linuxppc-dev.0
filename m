Date: Wed, 26 Dec 2001 09:24:16 -0700
From: Tom Rini <trini@mvista.com>
To: frowand@mvista.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: patch - KGDB read and write of IO registers
Message-ID: <20011226162416.GB15460@Bill-The-Cat.bloom.county>
References: <3C23BC8B.83D8F4DB@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C23BC8B.83D8F4DB@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Dec 21, 2001 at 02:49:47PM -0800, Frank Rowand wrote:

> The patch allows IO device registers to be accessed by KGDB via word
> (or halfword) loads and stores for word (or halfword) sized objects
> when naturally aligned.  The previous behaviour was to always do
> byte load and stores which can result in side effects when accessing
> an IO device register.
>
> A second fix in the patch is to pass the correct address to
> flush_icache_range() when writing to memory in hex2mem().

Looks good, applied.

--
Tom

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
