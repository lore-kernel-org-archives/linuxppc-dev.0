Date: Mon, 1 Dec 2003 12:30:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] zlibc updates for bootloader
Message-ID: <20031201193020.GG1166@stop.crashing.org>
References: <20031130145421.GA30681@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031130145421.GA30681@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 30, 2003 at 03:54:21PM +0100, Olaf Hering wrote:

> This patch fixes the zlibc debugging code. A printf is required for
> PReP, maybe also for other configs.

I'd like to suggest a different approach if possible.  That is to make
arch/ppc/boot/ make use of lib/zlib_deflate/.  Sam, should it be
possible to do something like this, build-wise ?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
