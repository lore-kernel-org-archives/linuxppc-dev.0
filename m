Date: Fri, 21 Sep 2001 11:20:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Peter Bergner <bergner@brule.borg.umn.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org,
	Debian PowerPC <debian-powerpc@lists.debian.org>, dan@debian.org
Subject: Re: [ANN] yaboot maintainer change
Message-ID: <20010921112047.B23691@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010920150939.32251@smtp.adsl.oleane.com> <20010920152246.B14835@plato.local.lan> <20010921114951.A211936@brule.borg.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010921114951.A211936@brule.borg.umn.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 21, 2001 at 11:49:51AM -0500, Peter Bergner wrote:

> Ethan Benson wrote:
> : comments and suggestions are welcome, flames should go to /dev/null.
>
> Just a little nit, but some people might be interested, as part
> of the "Various ppc64 & chrp fixes by Peter Bergner", we also
> added support for booting compressed images (ie, zImage).

As in objcopy ... && gzip -9 or the 'zImage' target?  They aren't exactly
the same..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
