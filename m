From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 16 Dec 2002 12:49:31 -0700
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
Message-ID: <20021216124931.B9431@duath.fsmlabs.com>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <20021213151808.GI19456@opus.bloom.county> <20021215121526.M30941@duath.fsmlabs.com> <15869.5023.549830.146265@argo.ozlabs.ibm.com> <20021215174120.E30568@duath.fsmlabs.com> <20021216150442.GJ6095@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021216150442.GJ6095@opus.bloom.county>; from trini@kernel.crashing.org on Mon, Dec 16, 2002 at 08:04:42AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


} I'm not sure how that would stop the growth of the '_devel' tree, it
} would just split it up into 4xx, and everything else.  And my goal of
} the new few weeks is to try and move everything that's not 4xx that I
} can get my hands on to test into the _2_4 tree.  I'm not sure just how
} much of that I'll actually be able to do, but I'm going to try.

There would be no _devel tree in that case.  They'd all be based on
Marcelo's so moving back and forth would be easier.  There would also be
more trees and smaller patches.

Right now, if you want an embedded board to boot your only chance is to try
the wildly divergent - likely unstable - _devel tree.  Having something
like this would be much nicer:


marcelo ---> linuxppc_2_4 --- linuxppc_2_4_4xx
                  |                 |
		  |		    ---> linuxppc_2_4_4xx_walnut
		  |		    |
		  |		    ---> linuxppc_2_4_4xx_crazystuff
		  |		    |
		  |		    ---> linuxppc_2_4_4xx_some_whacky_port
		  |
		  |
		  |
		  |---> linuxppc_2_4_something

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
