Date: Tue, 14 Aug 2001 11:15:14 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Occasional crash reports
Message-ID: <20010814111514.L23175@mikef-linux.matchmail.com>
References: <20010813163521.17302@smtp.adsl.oleane.com> <Pine.A41.3.96LJ1.1b7.1010813214052.84970D-100000@unlserve.unl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.A41.3.96LJ1.1b7.1010813214052.84970D-100000@unlserve.unl.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 13, 2001 at 09:59:05PM -0500, Takashi Oe wrote:
>
> I don't really know, but I can confirm that both 2.2.x and 2.4.x kernels
> are unstable on a beige g3 and a bmac equipped b/w g3.  I can crash them
> rather easily with regular programs, given a day or two.  I have not seen
> similar instability on other machines (dual g4, 7600, all nubus).
> Unfortunately, I don't have any time to track it down right now  :(

I've been able to trace that to the mace and bmac ethernet drivers, which
are *very* unreliable in 2.2.  Get the latest drivers from Donald Becker for
tulip, rtl8139, eepro100, etc. and you're set.  I haven't tried 2.4 yet.

Mike

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
