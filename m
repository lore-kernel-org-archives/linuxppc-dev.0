Message-ID: <3ADF422F.CBC1EC7@wanadoo.fr>
Date: Thu, 19 Apr 2001 21:53:19 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Benh-2.4.4-pre3 kills linuxconf
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


For a long time, I have been using linuxconf to switch between home and
office configurations on my iBook. This worked up to kernel version
2.4.4-pre1 (rsynced from the benh tree on April 12). With 2.4.4-pre3,
rsynced yesterday, linuxconf doesn't work any more. When I type
"linuxconf", it just sits there and waits, doing nothing. When I stop it
with ^C, then subsequent calls of linuxconf come back immediately saying
"Broken pipe." The kernel config is the same in both cases.

Has anyone seen this?

I am trying newer kernels mainly because of the recent improvements in
the pmud and the firewire subsystems. I am still hoping that one day my
iBook will be able to sleep *and* wake up correctly. Until now it
sleeps, but usually crashes after wakeup, or at least the network
system, ethernet and airport, is dead until the next reboot. My firewire
disk (the old 10GB IBM travelstar, free after I upgraded the iBook to
20GB, put into a firewire+USB enclosure) doesn't work either, even with
all the recent ieee1394 patches applied :-(

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
