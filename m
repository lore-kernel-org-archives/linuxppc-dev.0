From: Peter Bergner <bergner@brule.borg.umn.edu>
Date: Thu, 13 Dec 2001 10:58:09 -0600
To: Tom Rini <trini@kernel.crashing.org>
Cc: Adam C Powell IV <hazelsct@mit.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Why require CONFIG_BOOTX_TEXT for so much of offb?
Message-ID: <20011213105809.A244378@brule.borg.umn.edu>
References: <3C158758.5020608@mit.edu> <20011212130522.A238707@brule.borg.umn.edu> <20011213020019.GC28967@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011213020019.GC28967@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
: BOOTX_TEXT != BootX now tho.  It's for writing on the screen early on.
: Perhaps some name changing, define moving and a new header for ppc64?

That doesn't seem to be used for prom_prints(), so what early screen
prints would these be?  If ppc64 can make use of them, then some
"name changing, define moving and a new header for ppc64" would be the
right thing.  If not, then just replacing the #ifdef CONFIG_BOOTX_TEXT
with #ifndef CONFIG_PPC64 would seem to be the right decision.
The later would fix the compile problem for ppc64 and things would
be back to the way they used to work for ppc32.

Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
