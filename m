From: Josh Huber <huberj@WPI.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14306.21109.970188.33759@cpu.wpi.edu>
Date: Fri, 17 Sep 1999 10:38:45 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard shuts itself off
In-Reply-To: <19990917014905.A11682@io.nu>
References: <19990917014905.A11682@io.nu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Shaw Terwilliger writes:
> 
> I'm running Paul's stable kernel on my G3 Lombard.  If I run it hooked
> into the wall (through the power adaptor), the thing will run for
> weeks at a time (using snooze to drop the laptop into low-power
> mode in between usage).  I have a problem, though, when I have
> booted the machine using the wall adaptor and the unplug it.
I'm using the latest rsync tree of linux-pmac-stable as well...but I'm using a wallstreet machine (233mhz)

> After about 5 minutes on battery power (this battery is fully 
> charged), the machine just shuts off.  At first I thought it
> was a DPMS setting that kicked in after no activity, but this
> time I was typing away inside of X.  The machine just turns off.
I'm experiencing something similar to this...

It's almost as if the battery gets disconnected sometimes:
I put the machine to sleep in MacOS, unplug the power strip, put it in my case, and walk around with it for a while, open the case up, and...oh look at that the led isn't blinking any more!

Then, the same thing started happening with linux...

It gets to a point where I can't get the machine to boot again without putting the power plug back in.

I was suspicious of a faulty battery bay, so I (temporarily) moved the battery over to the other bay last night -- we'll see how that works.

> Anyone else had this problem?  It doesn't seem to happen if
> I boot the machine with the battery and leave it there... but
> only when I boot it plugged in, then unplug it.
I haven't tried this out yet...I almost always boot it with the power in.  Perhaps I'll try this.

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
