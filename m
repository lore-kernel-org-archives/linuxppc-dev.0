Date: Tue, 26 Oct 1999 18:38:26 -0400
From: Tom Vier <thomassr@erols.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: question about altivec registers
Message-ID: <19991026183826.A6668@zero>
References: <v03010d0cb43a9d52cd3e@[192.168.1.16]> <Pine.LNX.4.05.9910262020350.665-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.9910262020350.665-100000@callisto.of.borg>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 26, 1999 at 08:22:06PM +0200, Geert Uytterhoeven wrote:

> Moving around blocks of 512 bytes quickly thrashes the L1 cache, unless the
> loads/stores are done using cache-bypassing instructions (cfr. MOVE16 on '040).
> Don't know whether PPC has these (still no PPC guru :-(

from what i've read, you can disable cache for the altivec regs. this was
intended for doing infrequent vector ops between frequent vectors ops
(loops) without distrubing the cache.

-- 
Tom Vier - 0x27371A1C
thomassr@erols.com
http://users.erols.com/thomassr/zero/

DSA Key fingerprint:
42D4 82D6 6DF5 77EC 1251  30D2 D9E7 E858 2737 1A2C

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
