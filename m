Mime-Version: 1.0
Message-Id: <p06001800bb30f2ae6091@[192.168.0.254]>
Date: Tue, 8 Jul 2003 18:46:36 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: OT: wanting to write PCI daemon
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Now that I have your attention with the moronic subject line, ahem...
I feel more comfortable writing to this list than a gen-purpose linux
list; feel free to respond off-list.

As background, our current product is a PCI card that works in Wintel
and Mac boxes. We make a hardware driver for Win/OS9/OSX, and a
control and data acquisition application for Win/OS9/OSX that talks
to the driver, which in turn talks to DSPs on the PCI card.

Our company is faced with a redesign of our PCI card because of the
new PCI-X architecture coming up. We were already planning to drop
PCI altogether and move our card electronics to an external box that
runs a Linux kernel on a commercial motherboard, with internal
connections to our custom hardware, and communicating with external
computers via TCP/IP.

We have been moving along in this project slowly, and you could say
we're now caught with our pants down a bit, given that part of our
customer base will soon be buying G5s with PCI-X only (except the one
model).

As an interim solution until our next-gen hardware becomes real, we
want to use up our stock of existing PCI cards, and have mostly
settled on the idea that we can build a small box with a commercial
motherboard including 1 PCI slot. But to further our next-gen design,
we'd like to go ahead and run a linux kernel on it. That means it
will likely be Intel, so already I'm getting seriously close to
getting booted here, but this we know how to do. We then just need a)
to talk TCP/IP out the one end, and b) PCI on the other.

We had the naive idea that we could take an existing [open-source]
daemon that listens via TCP/IP on an ethernet interface, and modify
it for our purposes. We would then wed the kernel (and daemon) with
source code from PLX, the maker of our PCI controller chip (they
apparently provide Linux source as part of a $99 devel kit).

Now the questions: does this seem at all reasonable? Are there
obvious gotchas or better approaches? Is the idea of adapting an
existing daemon a stupid one? If not, which existing daemon might be
best adapted? Are there existing TCP/IP daemons that already are
adapted for use in a PCI environment? Is there already a free OOTB
solution for us? <grin>

Any other thoughts or suggestions? Is my terminology even in the
right place? Searching on sourceforge for "PCI" brings quite a few
hits, but our resources to investigate even the reasonable
possibilities are limited.

Regards, and thanks for your patience,

Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
