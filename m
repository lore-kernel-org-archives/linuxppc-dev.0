Message-ID: <3B55C8DF.5D8C0EF2@mvista.com>
Date: Wed, 18 Jul 2001 10:35:27 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Seg fault whenever NIP=c0006000
References: <Pine.LNX.3.95.1010718035902.16243A-100000@november.bhjjh.erols.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Justin (Gus) Hurwitz" wrote:
> So- it appears that avoiding address 0xc0006000, and only that address, is
> necessary for my kernel (true, I haven't tested every other byte of
> memory, but the kernel does appear stable). Anyone have ideas a to what
> could cause this?

Sorry if this is an obvious question, but is there any chance that there
is some code somewhere that is either intentionally or unintentionally
setting up a hardware breakpoint?

    Scott Anderson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
