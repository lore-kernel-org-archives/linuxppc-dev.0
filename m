Date: Mon, 10 Feb 2003 11:06:04 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Harald Welte <laforge@gnumonks.org>
Cc: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: VGA out/External Monitor on ibook 2
In-Reply-To: <20030209104414.GW13269@naboo.fugue.com>
Message-ID: <Pine.LNX.4.33.0302101055260.10914-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > case 2: Monitor not connected at boot up
> > The external monitor is "wavy". I turn the LCD off (m3mirror from benh)
> > and play around with timings, resolutions etc. The "waviness" gets more or
> > less but I could not find setting to make it stable. BTW, it is true for
> > both a CRT and flat-panel. Internal-LCD is fine (at 1024x768).
>
> Yes, I can confirm this behaviour.  It's really annoying because I
> cannot use my iBook2 for any of my presentations at conferences... and
> I'm really too lazy to carry a second old x86 notebook with me.
>
> > Has this been solved? If not, how can I help?
>
> I'm not aware of any solution :(

Someone lately posted a message detailing the problem (either here or on
debian-powerpc): the hsync and vsync pulses appear to be OK (correct
frequency) but have a phase jitter. Does that ring a bell with anyone
here? Does anyone know which PLL setting the hsync position is derived
from?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
