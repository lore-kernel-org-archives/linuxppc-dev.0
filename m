Date: Tue, 17 Jul 2001 10:17:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Armando Di Cianno <diciaa@rpi.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.7preX - unresolved symbols/compilation problem
Message-ID: <20010717101714.C2878@opus.bloom.county>
References: <20010717091235.G29799@garmonbozia.productivitynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010717091235.G29799@garmonbozia.productivitynet.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 17, 2001 at 09:12:35AM -0400, Armando Di Cianno wrote:

> I started with an ultra-basic install of YellowDog 2.0 on my TiBook (I
> wanted the glibc 2.2, and I like compiling everything else by hand).
> However, now that everything is up to par, I tried compiling both the benh
> and bk 2.4.7preX trees, and while they compile, upon reboot, all modules
> complain about unresolved symbols, even though cat'ng System.map reveals
> that those symbols are there (stuff like printk!!!).

YDL 2.0 ships with a version of modutils which is somehow missing
'/sbin/genksyms'.  Rebuild the srpm and install it and you'll be fine.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
