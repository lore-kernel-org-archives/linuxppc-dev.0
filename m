Date: Mon, 16 Jun 2003 10:03:31 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Shenrong <rshen@udtech.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC755 L2 Cache data parity error
Message-ID: <20030616150331.GB397@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <001401c3334f$c2e079f0$ca8d100a@justin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001401c3334f$c2e079f0$ca8d100a@justin>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Jun 15, 2003 at 11:06:38PM +0800, Shenrong wrote:
> size to 512k or 256k, but don't know why. We use both the PBGA and
> CBGA packages, seems CBGA version are some more stable(still has problem),
> don't know why too.

The first thing I thought of when I read this is heat issues -- especially because
of the mention of PBGA vs. CBGA.  Is your heat sinking/cooling adequate?

I had a problem once with a custom 405GP board that was not entirely dissimilar.
Running the OpenSSL 'speed' benchmark, the system would lock up doing the MD2 tests.
I couldn't fathom how a userland program could lockup the entire system.  One day,
just by chance, I happened to stand the board on end -- no more crashes.  The
difference had been the airflow underneath the device because it didn't have a
heatsink on it.  Consequently, I put a heatsink on the 405 and that fixed the
problem altogether.

>    It's more strange that I can simply let the error occur under Linux with
> continuous file copying in ram disk. But I can't let it occur under PPCBoot
> with whatever memory operations for even one time, whether use the L2 Cache
> memory as L2 Cache or as private memory. The L2 Cache has the same setting
> in the above two circumstances.

The only difference I could think of right away here is that under
Linux, you're doing burst reads and writes.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
