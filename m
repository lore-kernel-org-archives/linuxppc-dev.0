Message-ID: <38FF8897.D80916CC@mac.com>
Date: Thu, 20 Apr 2000 18:45:43 -0400
From: Chris Gehlker <canyonrat@mac.com>
MIME-Version: 1.0
To: Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Problems with building Paul's Stable Release
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a tiny bug report and a plea for help. I grabbed the latest
stable release, 2.2.15pre19, from Paul's tree to build for a Sawtooth.
Reading the archives of this list I see I'm supposed to disable PowerMac
Keyboard and I'm enabling usb hubs, keyboards and mice but no joy. My
usb devices are DOA.

The tiny bug is that the little pearl file mkmap in /drivers/usb has the
wrong permissions. Please excuse me if I'm violating etiquette by
reporting such a nit.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
