Date: Mon, 9 Aug 2004 16:25:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Angielski <jangiels@speakeasy.net>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH]: Fixes CONFIG_CONFIG_CPM2_UART bug in tty_io.c
Message-ID: <20040809232548.GD22109@smtp.west.cox.net>
References: <1092088985.4368.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092088985.4368.8.camel@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 09, 2004 at 06:03:05PM -0400, Jeff Angielski wrote:

> Here is a very small patch to fix a configuration bug in
> drivers/char/tty_io.c where the CPM2 UART would not work for non-8xx
> targets.

What tree is this against?  Thanks.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
