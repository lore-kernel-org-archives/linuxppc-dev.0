Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18444.34002.74202.564600@cargo.ozlabs.ibm.com>
Date: Mon, 21 Apr 2008 22:13:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Alexander van Heukelum" <heukelum@fastmail.fm>
Subject: Re: linux-next: x86-latest/powerpc-next merge conflict
In-Reply-To: <1208776790.4613.1248992953@webmail.messagingengine.com>
References: <20080421191231.41a34aef.sfr@canb.auug.org.au>
	<20080421095102.GB1666@elte.hu>
	<1208776790.4613.1248992953@webmail.messagingengine.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexander van Heukelum writes:

> Powerpc would pick up an optimized version via this chain: generic fls64
> ->
> powerpc __fls --> __ilog2 --> asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r"
> (x)).

Why wouldn't powerpc continue to use the fls64 that I have in there
now?

> However, the generic version of fls64 first tests the argument for zero.
> From
> your code I derive that the count-leading-zeroes instruction for
> argument zero
> is defined as cntlzl(0) == BITS_PER_LONG.

That is correct.  If the argument is 0 then all of the zero bits are
leading zeroes. :)

Regards,
Paul.
