Mime-Version: 1.0
Message-Id: <p04330100b5d563d5bdc6@[129.59.235.75]>
In-Reply-To: <200009010500.AAA20882@lists.linuxppc.org>
References: <200009010500.AAA20882@lists.linuxppc.org>
Date: Fri, 1 Sep 2000 08:56:16 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "Marcus H. Mendenhall" <mendenmh@telalink.net>
Subject: (more) 2.4 problems / G4/500/1GB dual processor / USB
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tried yesterday compiling 2.4.0-test7 from the linuxcare.au
linux-pmac-devel tree (I also tried the linux-pmac-benh tree with
similar results).  Comments:

The kernel only recognizes 512MB of memory. I was hoping 2.4 would
let me move beyond the 680 (or so) MB I can successfully access with
the 2.2.17 linux-pmac-stable kernel.

I get a series of PCI address conflicts when probing the PCI bus
which result in my ethernet card not being able to be turned on. I am
not using the built-in GMAC, but an older Apple 10/100 PCI card. This
does not happen with the linux-pmac-stable kernel.

The USB mouse and keyboard are completely messed up (using the new
input layer).  The mouse is frozen, and the keyboard returns
(thoroughly) scrambled keycodes.   I noticed in a previous comment
something about changing keycodes... is the setup completely
different in 2.4?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
