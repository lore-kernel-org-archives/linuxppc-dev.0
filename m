From: Cort Dougan <cort@fsmlabs.com>
Date: Sun, 15 Dec 2002 17:41:20 -0700
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
Message-ID: <20021215174120.E30568@duath.fsmlabs.com>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <20021213151808.GI19456@opus.bloom.county> <20021215121526.M30941@duath.fsmlabs.com> <15869.5023.549830.146265@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15869.5023.549830.146265@argo.ozlabs.ibm.com>; from paulus@samba.org on Mon, Dec 16, 2002 at 10:43:27AM +1100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


} Now that Marcelo is using BK, what I would really like to do is to
} kill both the linuxppc_2_4 and linuxppc_2_4_devel trees and move to a
} tree that is a child of Marcelo's linux-2.4 tree.

I've been moving patches from the _2_4 and _2_4_devel ppc trees over to the
marcelo tree.  I've love to see the switch so I don't have to do that!

} 4xx in particular is a problem because I'm not convinced about the
} approach that has been taken for some of the 4xx infrastructure.  The
} ocp stuff seems a lot more complicated than it needs to be, for
} instance.  There is no particular reason that I can see why the 8xx
} stuff in 2_4_devel shouldn't go to Marcelo for 2.4.21.

How about a linuxppc_2_4 that is a child of Marcelo's.  Then a
linuxppc_2_4_4xx (and what have you) that is a child of the linuxppc_2_4
tree?  It would make integration much much easier.  Right now the
diff between _2_4 and _2_4_devel seems to be non-monotonically increasing.
I think it would be hard to arrest that growth without switching to a
Macelo based tree.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
