Date: Wed, 26 Apr 2000 23:25:31 +0200
Message-Id: <200004262125.XAA14159@macocotte.inria.fr>
From: Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3906199F.1D7F995@dana.ucc.nau.edu> 
Subject: Re: Dual head on a Powerbook 
Reply-to: Jean-Jacques.Levy@inria.fr
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Already asked this question on Sun, 21 Nov 1999. And on Mon, 3 Jan 2000.
On Tue, 4 Jan 2000, there was following answer from Benh:

 "features like mirroring and multi-head provided by the
  Rage LT and LT Pro video controllers of the PowerBook are not enabled by
  Linux drivers. I know Brad Midgley is working on implementing the LT Pro
  multihead. It would probably be possible to more easily enable simple
  mirroring if someone takes the time to hack into the driver."

In the linuxcare web page, it's mentioned that

  "the video acceleration problem is truly weird, you can write to
   certain registers and only some bits go in, the other bits are stuck."

Myself, for a presentation, I boot (No Video Driver option) with video
on the external projector, and blank screen on LCD. It works; it's
very unconvenient; it's with Xpmac (otherwise too slow).

I would love to know current status. Is it not simpler to make a patch
for video mirroring? Which is enough for presentations.  Multihead is
a luxurious solution.

-JJ-

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
