Date: Sun, 21 Jan 2001 09:25:24 +0000
Subject: 2.4.1p8:don't "mount" audio CDs
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010121092528.53BFBDBA71@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It seems that if you (accidentally) do:

mount /dev/cdrom /mnt/cdrom  (with an audio CD in the tray)

(because it happens to be in your command history & you forgot ;)

it completely locks up the kernel.

no oops, no SysRq, no <option> power, no switch console - three keys is the
only way out.

(so not much useful info really) more of a "don't do that"... although it
seems a bit drastic for such an easy mistake.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
