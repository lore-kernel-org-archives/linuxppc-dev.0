Date: Thu, 28 Mar 2002 14:28:30 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: DST flag in NVRAM revisited (was: Re: NVRAM stuck in DST?)
Message-ID: <20020328142829.W26309@plato.local.lan>
References: <20020328040442.V26309@plato.local.lan> <20020328171859.4716@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020328171859.4716@mailhost.mipsys.com>; from benh@kernel.crashing.org on Thu, Mar 28, 2002 at 06:18:59PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 28, 2002 at 06:18:59PM +0100, benh@kernel.crashing.org wrote:
> >we should just deal with the RTC exactly how its delt with on x86, if
> >you have windows (or in our case MacOS) you tell hwclock the RTC is in
> >localtime and let it deal with it, if you don't have MacOS/windows you
> >tell it you have the RTC in GMT like its supposed to be and all is well.
>
> Which means that during boot, the kernel will have a wrong (local) time
> instead of UTC. That can be annoying.

only for a short period of time, look at debian woody for how they
invoke hwclock, it ensures this period is short.

but in any event its the price you pay for keeping a broken OS
installed and letting it control the hardware clock. it is certainly
not severe enough to justify all these fragile and broken kludges and
kernel bloat.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
