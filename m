Date: Mon, 16 Dec 2002 08:08:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for Arctic platform (405LP based)
Message-ID: <20021216150839.GK6095@opus.bloom.county>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <20021213151808.GI19456@opus.bloom.county> <20021215121526.M30941@duath.fsmlabs.com> <15869.5023.549830.146265@argo.ozlabs.ibm.com> <20021215174120.E30568@duath.fsmlabs.com> <20021216150442.GJ6095@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021216150442.GJ6095@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 16, 2002 at 08:04:42AM -0700, Tom Rini wrote:
>
> On Sun, Dec 15, 2002 at 05:41:20PM -0700, Cort Dougan wrote:
>
> > } 4xx in particular is a problem because I'm not convinced about the
> > } approach that has been taken for some of the 4xx infrastructure.  The
> > } ocp stuff seems a lot more complicated than it needs to be, for
> > } instance.  There is no particular reason that I can see why the 8xx
> > } stuff in 2_4_devel shouldn't go to Marcelo for 2.4.21.
> >
> > How about a linuxppc_2_4 that is a child of Marcelo's.  Then a
> > linuxppc_2_4_4xx (and what have you) that is a child of the linuxppc_2_4
> > tree?  It would make integration much much easier.  Right now the
> > diff between _2_4 and _2_4_devel seems to be non-monotonically increasing.
> > I think it would be hard to arrest that growth without switching to a
> > Macelo based tree.
>
> I'm not sure how that would stop the growth of the '_devel' tree, it
> would just split it up into 4xx, and everything else.  And my goal of
> the new few weeks is to try and move everything that's not 4xx that I
> can get my hands on to test into the _2_4 tree.  I'm not sure just how
> much of that I'll actually be able to do, but I'm going to try.

... with the exception of the current gt64260 code, which will hopefully
get an update so that it could move up-and-out.  But no promises there.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
