Date: Fri, 29 Dec 2000 12:36:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ron Bianco <ronb@junction.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: A stable linux 2.2.xx for sandpoint-8240 anywhere?
Message-ID: <20001229123605.G5661@opus.bloom.county>
References: <000501c071cd$44356c00$4d012ac7@warp-speed>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000501c071cd$44356c00$4d012ac7@warp-speed>; from ronb@junction.net on Fri, Dec 29, 2000 at 11:26:39AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 29, 2000 at 11:26:39AM -0800, Ron Bianco wrote:

> We've been working with the 2.3.16 port from MontaVista.
> There are problems as this port was based on an experimental and unstable
> kernel.

I'm not quite sure what's in the 2.3.16 port specifically, but your easiest
route would probably be the 2.4.x-testxx kernels, specifically the ones
from the 2_5 bitkeeper tree (http://www.fsmlabs.com/linuxppcbk.html,
2_5 is on 5005) as it's somewhat similar to 2.3.16 (so it shouldn't be too
hard to get your changes applied) and other 82xx boards are currently working
anyways.

Of course, Dan should probably speak up, as I'm just getting the hang of
all this stuff. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
