Date: Fri, 17 Sep 1999 01:49:05 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Lombard shuts itself off
Message-ID: <19990917014905.A11682@io.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm running Paul's stable kernel on my G3 Lombard.  If I run it hooked
into the wall (through the power adaptor), the thing will run for
weeks at a time (using snooze to drop the laptop into low-power
mode in between usage).  I have a problem, though, when I have
booted the machine using the wall adaptor and the unplug it.

After about 5 minutes on battery power (this battery is fully 
charged), the machine just shuts off.  At first I thought it
was a DPMS setting that kicked in after no activity, but this
time I was typing away inside of X.  The machine just turns off.

Anyone else had this problem?  It doesn't seem to happen if
I boot the machine with the battery and leave it there... but
only when I boot it plugged in, then unplug it.

... also, after the machine wakes up from a snooze, the audio
no longer seems to work.  Not a big problem, just wondered if
someone had seen that, too.

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
