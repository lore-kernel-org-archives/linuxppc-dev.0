Date: Fri, 21 Sep 2001 15:44:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: hollis@austin.ibm.com,
	Peter Bergner <bergner@brule.borg.umn.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org,
	Debian PowerPC <debian-powerpc@lists.debian.org>, dan@debian.org
Subject: Re: yaboot & zImage's
Message-ID: <20010921154420.H17555@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010920150939.32251@smtp.adsl.oleane.com> <20010920152246.B14835@plato.local.lan> <20010921114951.A211936@brule.borg.umn.edu> <20010921112047.B23691@cpe-24-221-152-185.az.sprintbbd.net> <20010921132904.C17347@austin.ibm.com> <20010921113329.C23691@cpe-24-221-152-185.az.sprintbbd.net> <3BABAB90.5AC649AD@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BABAB90.5AC649AD@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 21, 2001 at 05:05:20PM -0400, Dan Malek wrote:
> Tom Rini wrote:
>
> > > I've booted a zImage.rs6k-chrp from yaboot 1.2.5.
> >
> > That almost sounds silly.
>
> Actually, it's not very silly at all.  The zImage is significantly
> smaller than a corresponding vmlinux, so it takes much less time
> to load the image.

Yes, but it almost sounds silly since yaboot is a full blow bootloader.
Fer instance even, imho it'd make more sense for yaboot to take the
objcopy'ed & gzip'ed vmlinux and throw that at KERNELADDR or so.

> Also, many systems claim the lower memory where we want to load
> the kernel.  The only option is the load it in some higher
> memory hole, and then have it copy itself.  You may as well
> uncompress at the same time....

Yes, but if we've already loaded yaboot, couldn't we do the same thing
you're saying with a vmlinux.gz?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
