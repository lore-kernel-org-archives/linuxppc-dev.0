Date: Fri, 17 Sep 1999 10:32:25 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: Josh Huber <huberj@WPI.EDU>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard shuts itself off
Message-ID: <19990917103225.A12534@io.nu>
References: <19990917014905.A11682@io.nu> <14306.21109.970188.33759@cpu.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14306.21109.970188.33759@cpu.wpi.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:
> It's almost as if the battery gets disconnected sometimes:
> I put the machine to sleep in MacOS, unplug the power strip, put it in my case, and walk around with it for a while, open the case up, and...oh look at that the led isn't blinking any more!

Yes, it's just like like the battery got yanked out (which I've done
once; just once!  The Lombards have that bay release lever in the
ultimate "shirt-catching" position).  I know both times the machine
shut off without warning, I was nowhere near the lever.  Once it
was just sitting on a table, once in my lap.

> Then, the same thing started happening with linux...

I don't run MacOS on this laptop, so I don't have a frame of
reference that includes MacOS's power management.  I was assuming
my problems might be related to a 5-minute "no more wall power!"
PMU signal Linux might be mis-handling.  

I really haven't timed the delay before the outage; maybe today
I'll just remount root ro and watch the clock.

> It gets to a point where I can't get the machine to boot again without putting the power plug back in.

I've never had this problem.  For me the only problems are when the
machine is booted from the wall, then pulled and used with the
battery (full power, all four lights on the status thingy).

> I haven't tried this out yet...I almost always boot it with the power in.  Perhaps I'll try this.

I usually use my PowerBook with the power adaptor instead of the battery,
because I'm usually in a comfortable chair at home, and because I
really, really don't want to sit through a fsck of a 6 GB laptop
drive if I take it out somewhere.  :)

Something else for the experts:

I'm not sure how to read the status lights on my battery.

- When it's booted from the wall, with the battery in, usually
the "normal" things happens:  the battery lights are off until
I hit the button, then they come on for 4 seconds and go off.

- Sometimes, like when I unplug it from the wall, and then plug
it back into the wall, the lights will come on and stay on
for minutes.  Pressing the button does nothing.  I'm assuming
this is a short "charge" stage... maybe not.

- Sometimes, when it's been plugged into the wall for a long,
long time, and there should be no charging needed, the lights
will also stay on for minutes or hours at a time; pressing
the button won't turn them off.

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
