Message-ID: <392C3ED0.594EB6F7@alerton.com>
Date: Wed, 24 May 2000 13:42:56 -0700
From: Bill Roman <roman@alerton.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <m12uh7W-001SyaC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:

> - I am looking for a floating point validation test suite written in
>   C.  The test suite should start with the fundamentals and work out
>   from there.

Try paranoia.c. A web search should turn up multiple copies, I found one at

    http://www.enseeiht.fr/NetLib/paranoia/index.html

A while back I had the floating point emulator from kernel 2.3 patched into
kernel 2.2.13 running on an MBX, and it did reasonably well on this test as I
recall.

>From the comments in paranoia.c:

        A C version of Kahan's Floating Point Test "Paranoia"

                        Thos Sumner, UCSF, Feb. 1985
                        David Gay, BTL, Jan. 1986

        This is a rewrite from the Pascal version by

                        B. A. Wichmann, 18 Jan. 1985

        (and does NOT exhibit good C programming style).
    .
    .
    .

You may copy this program freely if you acknowledge its source.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
