Subject: Re: MPC860 patches for glibc
To: Brendan.Simon@ctam.com.au
Date: Thu, 6 Jan 2000 10:36:06 +1100 (EST)
Cc: linuxppc-dev@lists.linuxppc.org (linuxppc-dev),
        linuxppc-embedded@lists.linuxppc.org (linuxppc-embedded)
In-Reply-To: <3873C4A3.72079612@ctam.com.au> from "Brendan J Simon" at Jan 06, 2000 09:24:36 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000105233607.0D48DED@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brendan J Simon writes:
> I didn't realise there were 860 patches for glibc.
> Where can I get these patches from ?

The magic mailing list archive, of course (-:

http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00000.html

> What do they do ?

Fix the cache line size for dynamic loading, and rearrange the FPU stuff so
it doesn't get included when you build.

Regards,
Graham

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
