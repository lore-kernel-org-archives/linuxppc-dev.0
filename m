Message-ID: <3975C772.871AA333@ssl.co.uk>
Date: Wed, 19 Jul 2000 16:21:22 +0100
From: Sacha Varma <sacha@ssl.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: PCI compatibility
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I came across http://til.info.apple.com/techinfo.nsf/artnum/n16365 , a 1994 note
which discusses compatibility of PCI cards in general with Macs/OpenFirmware.

It's quite terse but states that PCI cards that need to be active on boot (video cards) will generally not work, and cards that don't generally will.

I'm just curious (I was wondering why there was no support for various nifty non-AGP PC graphics cards, and also why the PC USB card I installed yesterday works fine under MacOS) but

. can anyone point me to more detailed resources?
. what's the state of play 6 years on? is there a trend towards OF compliance?
. what does "active on boot" really mean?
. why can't a card be activated after boot, programmatically?
. does anyone maintain a list of compatible PCI cards (of all types)?


Thanks & happy BBQ-ing,

Sacha.

--
sacha varma : system simulation ltd : +44 (0) 20 7836 7406

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
