Date: Tue, 20 Aug 2002 13:53:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compile fix for 4xx (linuxppc_2_4_devel)
Message-ID: <20020820205343.GC891@opus.bloom.county>
References: <20020820004500.GB998@zax> <20020820204731.GB891@opus.bloom.county> <20020820144707.I24379@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020820144707.I24379@host110.fsmlabs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 20, 2002 at 02:47:07PM -0600, Cort Dougan wrote:

> } Actually, I'd rather keep it broken until either no one comments on
> } Milton's continued patching of this code (and it's implicitily OK'ed,
> } and myself or Troy will commit it), or there's comments on his changes
> } and ....
>
> I can submit patches to break other ports if you'd like that, as well.

Well, since what Troy commited came from you, IIRC, you already have. :)

But seriously, I'd rather not apply a fix for one port that still leaves
other ports broken.  Milton's patch fixes 4xx, as well as CHRP (which is
currently unhappy) along with the cleanups introduced in what he did.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
