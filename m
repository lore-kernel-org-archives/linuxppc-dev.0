Date: Wed, 16 Oct 2002 09:22:08 -0400
From: Patrick Mahoney <pmahoney@8d.com>
To: Cameron Rich <CameronR@nulec.com.au>
Cc: "'Conn Clark'" <clark@esteem.com>,
	Patrick Mahoney <pmahoney@8d.com>,
	May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx - power save modes - PIT
Message-ID: <20021016132208.GA16734@segfault.usine.8d.com>
References: <1072F1A27E99D3119747005004B9A380016F9573@MAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1072F1A27E99D3119747005004B9A380016F9573@MAIL>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I've tried Conn's code, but I'm experiencing problems with PLPRCR[CSCR] as
> being 1 all the time after a rfi. I am also occasionally seeing MSR_POW set
> to 1 after the rfi return.

Well the 2.4 Linux kernel does not support runtime modifications to
the clock rate. So what's the point of playing with CSCR?

>
> I can work around this problem by setting PLPRCR[CSCR] = 0 and MSR_POW = 0
> after the rfi and this eventually works. But is this the solution? I'm also
> noticing no great decrease in power consumption even though I've only got a
> couple of (sleeping) processes. And it seems that there is (mostly) no time
> between entering Doze Low mode and the rfi which confirms the unsatisfactory
> power consumption figures.

I notice no decrease at all!  :(

I set both crqen and prqen in the bootloader. The idled routine gets
entered and executed repeatedly, but no decrease in current
consumption can be observed.


Pat Mahoney

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
