Date: Sun, 21 Jan 2001 14:28:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Hanley <sjh@wibble.net>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [patch] missing exported symbols
Message-ID: <20010121142823.B6223@opus.bloom.county>
References: <20010121144057.A27643@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010121144057.A27643@wibble.net>; from sjh@svana.org on Sun, Jan 21, 2001 at 02:40:57PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 21, 2001 at 02:40:57PM +1100, Steven Hanley wrote:

> The first one I am pretty sure belongs in this file as i have noticed a few
> other archs have to export it here.

Err, what needs this symbol tho?  And are you sure this is actually needed?
I'm about to re-do my modtest config vs 2.4.1pre9, but as of ~2.4.0 release
or an early 2.4.1 the bk tree was fine wrt modules now..  And, as of 2.4.1pre9
only sh exports flush_dcache_page, and sparc64 exports __flush_dcache_page,
so are you sure this is needed?

> The gmac one i am unsure if this is the best place to put the export, but it
> works so I put it here.

This has been fixed in the 2_4 bk for atleast a week, and 2_5 for much longer.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
