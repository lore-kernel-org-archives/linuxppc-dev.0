Message-ID: <37F463A0.E6AB9D17@cern.ch>
Date: Fri, 01 Oct 1999 09:32:49 +0200
From: Daniel Haas <Daniel.Haas@cern.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: X 3.3.5 still Broken 
References: <199910010459.XAA03311@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I also had problems upgrading to 3.3.5. I thought I would finally get
FBDev accelerated working on my Wallstreet, but till now, no go. So I
wanted to switch back to Xpmac, which is also broken in 3.3.5. Only the
unaccelerated version seems to work. If I do a startx -- -mach64 it
completely hangs the machine (I only get a flashing prompt) and I can
not even get back to a virtual console, the keyboard shortcut to kill X
also does not work there. So I ended up with a set of 3.3.5-stuff and
just downgraded Xpmac to 3.3.3 again, which seems to work at the moment.
(Ben claimed, atyfb should be fine now in the new 2.2.12 kernel, but I
still get a white screen if I give video=atyfb as an option, and this
already at the console level...)

Daniel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
