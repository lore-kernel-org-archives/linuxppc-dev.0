Date: Thu, 13 Dec 2001 10:04:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Peter Bergner <bergner@brule.borg.umn.edu>
Cc: Adam C Powell IV <hazelsct@mit.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Why require CONFIG_BOOTX_TEXT for so much of offb?
Message-ID: <20011213170446.GG28967@cpe-24-221-152-185.az.sprintbbd.net>
References: <3C158758.5020608@mit.edu> <20011212130522.A238707@brule.borg.umn.edu> <20011213020019.GC28967@cpe-24-221-152-185.az.sprintbbd.net> <20011213105809.A244378@brule.borg.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011213105809.A244378@brule.borg.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 13, 2001 at 10:58:09AM -0600, Peter Bergner wrote:
> Tom Rini wrote:
> : BOOTX_TEXT != BootX now tho.  It's for writing on the screen early on.
> : Perhaps some name changing, define moving and a new header for ppc64?
>
> That doesn't seem to be used for prom_prints(), so what early screen
> prints would these be?

Well, take a look at arch/ppc/kernel/btext.c.  I _think_ one of the
things this lets you do is if you drop into xmon you can still use the
screen.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
