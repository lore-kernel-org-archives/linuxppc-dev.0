From: Josh Huber <huberj@WPI.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14404.17703.247016.528826@cpu.wpi.edu>
Date: Tue, 30 Nov 1999 16:44:07 -0500 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: wallstreet power usage...
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey, for those who know, how could I extend the battery life for my WallStreet when it's both sleeping, and when it's awake...

does the /proc/sys/kernel/powersave-nap setting do anything for the wallstreet series machines?

With Batmon, it seems that the power usage is like:
powersave-nap      current
0                  -1350
1                  -1550

the number varies, of course...but they appear to be about 200 off from eachother.

Doesn't this seem a little backwards to any of you? It seems backwards to what Paul is doing for the 3400 in the pwrctl script.

Any other tips?  Is it possible to turn off hardware like: ethernet, sound, video (I know this is a little buggy...for my machine anyway)?

I ask, because while the machine is sleeping, in about 6 hours 25% of the battery seems to be used, which is far far more than used when sleeping in macos.

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
