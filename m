Message-ID: <3BABAB90.5AC649AD@mvista.com>
Date: Fri, 21 Sep 2001 17:05:20 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: hollis@austin.ibm.com,
	Peter Bergner <bergner@brule.borg.umn.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org,
	Debian PowerPC <debian-powerpc@lists.debian.org>, dan@debian.org
Subject: Re: yaboot & zImage's
References: <20010920150939.32251@smtp.adsl.oleane.com> <20010920152246.B14835@plato.local.lan> <20010921114951.A211936@brule.borg.umn.edu> <20010921112047.B23691@cpe-24-221-152-185.az.sprintbbd.net> <20010921132904.C17347@austin.ibm.com> <20010921113329.C23691@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> > I've booted a zImage.rs6k-chrp from yaboot 1.2.5.
>
> That almost sounds silly.

Actually, it's not very silly at all.  The zImage is significantly
smaller than a corresponding vmlinux, so it takes much less time
to load the image.

Also, many systems claim the lower memory where we want to load
the kernel.  The only option is the load it in some higher
memory hole, and then have it copy itself.  You may as well
uncompress at the same time....


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
