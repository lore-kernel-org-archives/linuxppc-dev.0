Message-ID: <401FE138.8080807@lycos.nl>
Date: Tue, 03 Feb 2004 18:58:16 +0100
From: Mikolaj Krzewicki <mkrzewicki@lycos.nl>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: benh performance problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi all,
starting 2.6.0-test9-benh3 i noticed an increased system overhead on my
ibook 500. Each process eats much more cpu time than in 2.4 or even
vanilla 2.6.
gkrellm takes 1% instead of 0.1, xmms 5% instead of ~1% and so on.
I benchmarked the lot with octave and it indeed runs ~10% slower on the
benh kernels.
I would use vanilla 2.6.1 but it won't sleep/wake correctly (at all).
All pre-2.6.0-test9-benh3 kernels worked fast but would't sleep/wake either.
I tried to isolate the patch responsible but failed.
Has anybody come across similar behaviour?
greetings, M.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
