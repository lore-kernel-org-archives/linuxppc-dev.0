Date: Wed, 13 Feb 2002 22:14:50 +1100
From: Anton Blanchard <anton@samba.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: performance monitor exceptions
Message-ID: <20020213111450.GF3886@krispykreme>
References: <20020211233730.E5079@almesberger.net> <20020212125502.32396@mailhost.mipsys.com> <20020212193317.F5079@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020212193317.F5079@almesberger.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> Bingo ! That seems to be the one:
>
> http://www.mot.co.jp/SPS/html/lit/pdf/mpc7410pns_rev0.pdf
>
>   #5:
>   Description: Consecutive Performance Monitor, Decrementer,
>   or Thermal Management Interrupts may become non-recoverable.
>
>   Work-Around: Avoid enabling any combination of
>   Performance Monitor, Decrementer, or Thermal Management
>   Interrupts at the same time.

Thats rather ugly :( BTW I have run kernel profiling off the performance
monitor exception on ppc64 which has been very useful (it allowed us
to profile inside interrupt disabled regions)

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
