Mime-Version: 1.0
Message-Id: <p04330100b627ff09296b@[192.168.0.1]>
Date: Fri, 3 Nov 2000 00:53:40 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: whacked out 2.2.18pre17?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a PowerTowerPro with a 500/1M PowerLogix G3 upgrade, have been
running Paul's 2.2.17 linux-pmac-stable for a while now (originally
rsynced from penguinppc.org), with great success, using BootX 1.1.3.

But for the last 4 nights I've been trying to run 2.2.18pre17 (also
rsynced from penguinppc.org) with no luck. The compile always
succeeds (just a vanilla compile, no changes to the default config),
but I either cannot boot completely, or the boot completes but is
seriously messed up.

The first night, all it would do is freeze at "booting..."

The second night, it booted, but the no video checkbox was somehow
inverted in operation. IOW, with no video turned on (I have a twin
turbo card, OFfb is my only choice in running X), I never get the
OFfb driver, it always insists on loading the imsttfb driver, so X is
impossible.

Last night, the video anomaly was still in effect, but the boot never
completed (kernel panic after an error that I cannot recall to save
me now)

Tonight, again the video anomaly is also still in effect, but the
boot never completes again, however for a different reason (kernel
panic after "machine check in kernel mode" which leads to the message
"unknown values in srr1").

I am aware that this kernel is being worked on daily (that's why I
try to rebuild it each night), but I'm a little surprised that I am
having so much trouble with a pre17 kernel. Anybody know what's up?
Is this thing going through such big changes that I should let it go
for a while instead of trying each night?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
