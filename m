Date: Sun, 9 Feb 2003 11:44:14 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: VGA out/External Monitor on ibook 2
Message-ID: <20030209104414.GW13269@naboo.fugue.com>
References: <20030120155921.GA22300@haar.ae.gatech.edu>
Mime-Version: 1.0
In-Reply-To: <20030120155921.GA22300@haar.ae.gatech.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 20, 2003 at 10:59:21AM -0500, Manuj Dhingra wrote:
>
> 	I know this has been asked before, but I did not come across any
> solutions, so let me appologise if I missed them.
>
> I have a: ibook 2 (white ibook from summer of 2001) 500MHz. It has a ATI
> Rage 128 graphics card which my OF calls ATY,RageM3p29s. The aty128fb
> module is used for video framebuffer, and I can't seem to get VGA mirror
> to work.

I have exactly the same model.

> case 2: Monitor not connected at boot up
> The external monitor is "wavy". I turn the LCD off (m3mirror from benh)
> and play around with timings, resolutions etc. The "waviness" gets more or
> less but I could not find setting to make it stable. BTW, it is true for
> both a CRT and flat-panel. Internal-LCD is fine (at 1024x768).

Yes, I can confirm this behaviour.  It's really annoying because I
cannot use my iBook2 for any of my presentations at conferences... and
I'm really too lazy to carry a second old x86 notebook with me.

> Has this been solved? If not, how can I help?

I'm not aware of any solution :(

--
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
