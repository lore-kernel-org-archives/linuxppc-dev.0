Subject: Re: benh performance problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikolaj Krzewicki <mkrzewicki@lycos.nl>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <401FE138.8080807@lycos.nl>
References: <401FE138.8080807@lycos.nl>
Content-Type: text/plain
Message-Id: <1075847083.17327.31.camel@gaston>
Mime-Version: 1.0
Date: Wed, 04 Feb 2004 09:24:44 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-02-04 at 04:58, Mikolaj Krzewicki wrote:
> hi all,
> starting 2.6.0-test9-benh3 i noticed an increased system overhead on my
> ibook 500. Each process eats much more cpu time than in 2.4 or even
> vanilla 2.6.
> gkrellm takes 1% instead of 0.1, xmms 5% instead of ~1% and so on.
> I benchmarked the lot with octave and it indeed runs ~10% slower on the
> benh kernels.
> I would use vanilla 2.6.1 but it won't sleep/wake correctly (at all).
> All pre-2.6.0-test9-benh3 kernels worked fast but would't sleep/wake either.
> I tried to isolate the patch responsible but failed.
> Has anybody come across similar behaviour?
> greetings, M

I switched to HZ=1000, the userland procps utilities (like ps and top)
tend to not properly deal with that, at least earlier versions, afaik.

I suspect it's just display crap.

Alos, you can find a more recent kernel than that :) My bk tree is
currently at 2.6.2-rc3-ben1

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
