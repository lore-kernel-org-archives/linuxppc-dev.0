Message-ID: <3BB5EA1D.554D7617@mvista.com>
Date: Sat, 29 Sep 2001 11:34:53 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
References: <20010923180118.83CBB1009E@denx.denx.de> <3BAEB9DA.232C8FEB@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> I'm not in the bootrom business.  While your experience is nearly
> exclusively PPCboot, mine is nearly everything but PPCboot.

I guess I should try to rephrase this.  My effort to use a minimal
amount of words missed the point I was trying to make.

When I'm working on a new Linux port, I try to get the most done
with the minimal amount of effort.  I (or the customer paying me)
try to use the bootrom that is on the board from the supplier,
rather than get "into the bootrom business" when the goal is
to port a kernel.  That's why the piggyback loaders exist, to
bridge the gap between a variety of boot roms and the kernel.
If a bootrom doesn't exist or is quite inferior to the job,
I would certainly port PPCBoot and use that.

So, while lots of people work on PPCBoot (which I am thankful)
and see it on a daily basis, I seldom see it in the commercial
production environments.  I'll change that whenever it it possible.
The challenge changing or writing the boot rom is often more
work and testing that the kernel port.  The complexity of the
processors and memory controllers, sometimes special hardware
tools and development boards, and of course documentation to
get this done right isn't always available outside of the
company that designed the system.

My real concern is PPCBoot is tied very tightly to the Linux
start-up environment.  Through these last few messages, I understand
the design reasons for features and attempt to minimize code
duplication.  I just want everyone to be aware, as is happening
and discussed today, that this environment is subject to change
as we modify features and attempt to consolidate the code in
the piggyback loaders that everyone except PPCBoot uses.

I hope this helps.

Thanks.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
