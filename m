Date: Fri, 21 Sep 2001 11:33:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: hollis@austin.ibm.com
Cc: Peter Bergner <bergner@brule.borg.umn.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org,
	Debian PowerPC <debian-powerpc@lists.debian.org>, dan@debian.org
Subject: Re: yaboot & zImage's
Message-ID: <20010921113329.C23691@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010920150939.32251@smtp.adsl.oleane.com> <20010920152246.B14835@plato.local.lan> <20010921114951.A211936@brule.borg.umn.edu> <20010921112047.B23691@cpe-24-221-152-185.az.sprintbbd.net> <20010921132904.C17347@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010921132904.C17347@austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 21, 2001 at 01:29:04PM +0000, hollis@austin.ibm.com wrote:
> On Fri, Sep 21, 2001 at 11:20:47AM -0700, Tom Rini wrote:
> >
> > On Fri, Sep 21, 2001 at 11:49:51AM -0500, Peter Bergner wrote:
> > >
> > > Just a little nit, but some people might be interested, as part
> > > of the "Various ppc64 & chrp fixes by Peter Bergner", we also
> > > added support for booting compressed images (ie, zImage).
> >
> > As in objcopy ... && gzip -9 or the 'zImage' target?  They aren't exactly
> > the same..
>
> I've booted a zImage.rs6k-chrp from yaboot 1.2.5.

That almost sounds silly.  I guess I should try and find the code, but I'm
guessing it copies from an FS into memory and then runs that?  yaboot doesn't
do compression yet, yes?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
