Message-ID: <3BA7FE96.CA24D4EE@carts.com>
Date: Tue, 18 Sep 2001 19:10:30 -0700
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Init acting strange
References: <001e01c140ac$88e8b830$fb5a01d9@crtc.corp.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been trying to get init working for a while now but I can't getting
logging in to work correctly, and I'm out of ideas, maybe someone can help

I'm using HHL 2.0 and the ramdisk is made from the target app rpms. I'm using
the default passwd file. Do shadow passwords or anything like that need to be
compiled in the kernel for the hhl2.0 login stuff to work??

here's what I'm seeing:

INIT: version 2.78 booti
Mounting local filesystems...
not mounted anything
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: done.
Cleaning: /tmp /var/lock /var/run.
INIT: Entering runlevel:
Starting system log daemon: syslogd klogd.
Starting internet superserver: inetd.

MontaVista Software's Hard Hat Linux 2.0

(none) login: root

MontaVista Software's Hard Hat Linux 2.0

(none) login: guest

MontaVista Software's Hard Hat Linux 2.0

(none) login: kevin

MontaVista Software's Hard Hat Linux 2.0

(none) login: nobody

MontaVista Software's Hard Hat Linux 2.0

(none) login:
MontaVista Software's Hard Hat Linux 2.0

(none) login:


Thanks guys!

Kevin Fry


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
