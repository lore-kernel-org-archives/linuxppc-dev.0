Date: Mon, 7 Apr 2003 10:43:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch for PCORE on linuxppc_2_4_devel
Message-ID: <20030407174355.GD16622@ip68-0-152-218.tc.ph.cox.net>
References: <3E8E2D71.8050707@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E8E2D71.8050707@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 04, 2003 at 06:12:17PM -0700, Mark A. Greer wrote:

> This patch does the following:
> a) Modifies the CONFIG_MORE_COMPILE_OPTIONS setup at the bottom of
> arch/ppc/config.in.  The way that it was didn't work well and seemed
> difficult to read.  I believe that the new way is "more correct" and
> easier to understand

Didn't work well when?  Then intent is that if you don't select this
option, you still get -g added when CONFIG_KGDB=y so that you can
effectivly use gdb.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
