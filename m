From: benh@kernel.crashing.org
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP/HIGHMEM/7450 status ?
Date: Thu, 6 Jun 2002 19:45:30 +0200
Message-Id: <20020606174530.22442@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.33.0206061251190.20358-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0206061251190.20358-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>On Thu, 6 Jun 2002 benh@kernel.crashing.org wrote:
>>Xserve uses 7455 (like newer dual G4s), which doesn't seem to exhibit
>>the problem.
>
> Damn... does this mean that the 7450 machines are lemons (wouldn't
>surprise me if the answer was a resounding 'yes')?

I can't say for sure. It seems we are hitting a CPU bug, but after
studying the errata and trying all sort of ways to "catch" the dead
CPU when the lockup happen, I had to give up.
It seems even tweaking the CPU reset line won't get it back from the
deadlock situation (I'm tweaking it using the firewire controller
tapping Apple's KeyLargo ASIC GPIO registers, this works fine when
the CPU isn't locked up in this state).

> herrenschmidt.wcg.mcgill.ca

hehe, nice ;) though I wouldn't like having to type that name every
day to telnet to the box ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
