Message-ID: <3AFD9868.29C558@folkwang-hochschule.de>
Date: Sat, 12 May 2001 22:09:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: pismo sleep behaviour w/ 2.4.4-benh
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello linuxppc-dev people !

i have been running the mentioned system for about 10 days now,
using the latest pmud daemon, and it works fine for me, except:

* the box usually falls asleep again after waking up. when woken
again, it stays up like it should.
* every 10 or so sleep cycles, the machine locks up. blank screen,
no standby-led, and i can only power off with ctrl-alt-apple-power.
sysrq fails, too.
* the box falls asleep sometimes even when i'm busy typing or moving
the mouse. this happens at least once every half hour.

some minor glitches that might be unrelated to power management:
* the first console cannot issue ctrl commands like break or
suspend, while the others still do. resetting doesn't help.
* there seems to be a problem under KDE with keyboard/trackpad
focus: sometimes they are attached to different windows.

i'd like to help tracking this down, but i'm rather new to the ppc
platform, so please tell me what to do.
is there a place where i can monitor power management events ? (more
detailed than in the syslog)

regards,

jörn


--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
