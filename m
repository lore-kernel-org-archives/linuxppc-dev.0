Date: Fri, 9 Apr 2004 15:06:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christian Kujau <evil@g-house.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: still unable to compile with kgdb enabled
Message-ID: <20040409220646.GB1787@smtp.west.cox.net>
References: <40771841.8040001@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40771841.8040001@g-house.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 09, 2004 at 11:40:17PM +0200, Christian Kujau wrote:

> hi,
>
> happily compiling kernels from 2.5 to 2.6 i finally wanted to give KGDB
> a try as suggested often enough. but i fail to do this.
[snip]
> i was looking for a kgdb patch on kgdb.sourceforge.net, but the latest
> version there is KGDB 2.0.1-2.0.5, which is for linux-2.6.1 only. on
> http://spop.free.fr/kgdb/ i found a kgdb-1.9-for-2.4.25.patch.bz2,
> applying cleanly, but still gives me errors and does not compile:

The CVS version of the patch is against 2.6.5, and if you only pass in
'kgdbwait', it should work w/o mods (otherwise it breaks in very early,
and requires some additional work).  I've tested this out on a few
machines locally, but not PPC_MULTIARCH, so there might be a few
incidental things required to be fixed.  I've been using the KGDB_8250,
and not PPC_SIMPLE_SERIAL, but I plan on testing that sometime in the
future.

FWIW, I'm about to go off for 2 weeks vacation, so I probably won't be
able to help you, if it doesn't work right away.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
