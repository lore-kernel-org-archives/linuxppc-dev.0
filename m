Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: still no luck with Radeon or Adaptec SCSI controller in 2.4.X
Date: Sun, 7 Oct 2001 21:44:13 -0400
References: <v03110700b7e6434b6153@[64.230.151.19]> <v03110701b7e646731f26@[64.230.148.35]> <20011007163351.C16260@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011007163351.C16260@cpe-24-221-152-185.az.sprintbbd.net>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <20011008014159.MXEV19401.tomts15-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> You have to have the new driver off or as a module.

Aha!  Thanks, I should have thought of that.  I recompiled with the old
AIC-7XXX driver and now SCSI works like a charm!  No more wierd aborts.

The new driver and my setup just don't get along.

So with that fixed, I tried to get the network working but ran into
trouble.

- I missed loading the ipchains module since I was running ipchains on
2.2.19

- I missed the fact that my two ethernet cards are now recognized in
reverse order (eth1 is the internal BMAC+ when it was eth0 previously).

This of-course messed up all my ipchains and masquerading.

Arrghhh!  Anyway it is working now!

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
