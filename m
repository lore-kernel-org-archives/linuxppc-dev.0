Date: Fri, 26 Jan 2001 08:09:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kostas Gewrgiou <gewrgiou@imbc.gr>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Ani Joshi <ajoshi@shell.unixbox.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Matrox and XFree86 4.0.2 update
Message-ID: <20010126080923.I594@opus.bloom.county>
References: <20010125172716.F594@opus.bloom.county> <Pine.LNX.4.05.10101260910390.497-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10101260910390.497-100000@callisto.of.borg>; from geert@linux-m68k.org on Fri, Jan 26, 2001 at 09:21:59AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 26, 2001 at 09:21:59AM +0100, Geert Uytterhoeven wrote:

> I just checked the Debian binary, and indeed it isn't. IIRC patches existed a
> few years ago.

They did/do exist, but were never completed.  Same person who did the matrox
accel for Xpmac (and who's name slips my mind right now..)

So can we "break" matroxfb and me it use LE?  (And, just a thought, this
could be dependant on Xpmac compat or not, because Xpmac will choke on
an LE matrox I'm gonna guess...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
