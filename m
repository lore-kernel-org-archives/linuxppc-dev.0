Date: Fri, 26 Oct 2001 12:52:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: will the real ppc kernel please stand up
Message-ID: <20011026125237.A14005@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BD9B30C.929F4747@midrivers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BD9B30C.929F4747@midrivers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 26, 2001 at 01:01:32PM -0600, Mark Pilon wrote:

> naively hoping to get something stable, I pulled linuxppc_2_4, configured
> it for ppc4xx / walnut and attempted to build it.  no luck:

The '2_4' tree doesn't have working 4xx support.

[snip]
> does anyone know where & how to get a reasonably recent snapshot of
> the development tree which builds?

linuxppc_2_4_devel should be fine.  linuxppc_2_4 has never had working
4xx support.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
