Date: Fri, 17 Sep 1999 10:29:56 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Shaw Terwilliger <sterwill@io.nu>
cc: Josh Huber <huberj@wpi.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard shuts itself off
In-Reply-To: <19990917103225.A12534@io.nu>
Message-ID: <Pine.LNX.3.96.990917102529.5903D-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 17 Sep 1999, Shaw Terwilliger wrote:

> Yes, it's just like like the battery got yanked out (which I've done
> once; just once!  The Lombards have that bay release lever in the
> ultimate "shirt-catching" position).  I know both times the machine
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Same thing on the WallStreet.  And I thought I was the only one who found
that obnoxious.  :-)

David


> > Then, the same thing started happening with linux...
> 
> I don't run MacOS on this laptop, so I don't have a frame of
> reference that includes MacOS's power management.  I was assuming
> my problems might be related to a 5-minute "no more wall power!"
> PMU signal Linux might be mis-handling.  

Did you remove the cord from the back or just the wall?


> I'm not sure how to read the status lights on my battery.
> 
> - When it's booted from the wall, with the battery in, usually
> the "normal" things happens:  the battery lights are off until
> I hit the button, then they come on for 4 seconds and go off.
> 
> - Sometimes, like when I unplug it from the wall, and then plug
> it back into the wall, the lights will come on and stay on
> for minutes.  Pressing the button does nothing.  I'm assuming
> this is a short "charge" stage... maybe not.

Assuming it's like the wallstreet in this regard, the lights stay on while
the battery is charging to indicate the charge status.  As soon as it
finishes charging, they go off.


> - Sometimes, when it's been plugged into the wall for a long,
> long time, and there should be no charging needed, the lights
> will also stay on for minutes or hours at a time; pressing
> the button won't turn them off.

Again, based on the wallstreet's behaviour, sometimes the battery gets
confused. Eject the battery and reinsert it (leave the power cord plugged
in so your machine doesn't die) and it should probably figure out what's
going on.


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
