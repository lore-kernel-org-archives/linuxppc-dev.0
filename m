Message-ID: <3BFF05BC.A0305E7A@carts.com>
Date: Fri, 23 Nov 2001 18:28:12 -0800
From: Kevin Fry <kevin@carts.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: cross-compiling libraries
References: <20011122131718.999A6F9BA@denx.denx.de> <8597.011122@digitel.com.br>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Okay this is probably a newbie, RTFM question, but if you could just point me in
the right direction, I'd
appreciate it.

I need to compile some 1394 libraries for my embedded 8260 board (HHL 2.0). These
are the libraw1394 libraries needed for Firewire.  They have a ./configure script
and everything, but if I tell the script --target=powerpc-linux I get 100's of
make errors.  I'm using the HHL2.0 cross compiler, maybe that needs something
extra to be done?

Any advice on manually cross compiling libraries?

I can include the ./configure file if it would help.

Thanks!

Kevin Fry
Carts llc


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
