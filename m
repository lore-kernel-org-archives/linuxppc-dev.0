Message-ID: <3C082FD5.D1F6C997@carts.com>
Date: Fri, 30 Nov 2001 17:18:13 -0800
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: PPC cross-compiling 1394 libraries 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I need to compile some 1394 libraries for my embedded 8260 board running
HHL 2.0. These
are the libraw1394 libraries needed for Firewire.  They have a
./configure script
and everything, but if I tell the script --target=powerpc-linux I get
100's of
make errors.  I'm using the HHL2.0 cross compiler, maybe that needs
something
extra to be done?

Any advice on cross compiling libraries would be very appreciated?

I sent this before, but i bounced back, so I'm not sure if it made it to
the list or not. If so, I'm sorry for the double post.

Kevin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
