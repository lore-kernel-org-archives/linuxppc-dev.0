From: hollis@austin.ibm.com
Date: Fri, 21 Sep 2001 13:29:04 +0000
To: Tom Rini <trini@kernel.crashing.org>
Cc: Peter Bergner <bergner@brule.borg.umn.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org,
	Debian PowerPC <debian-powerpc@lists.debian.org>, dan@debian.org
Subject: Re: yaboot & zImage's
Message-ID: <20010921132904.C17347@austin.ibm.com>
References: <20010920150939.32251@smtp.adsl.oleane.com> <20010920152246.B14835@plato.local.lan> <20010921114951.A211936@brule.borg.umn.edu> <20010921112047.B23691@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010921112047.B23691@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 21, 2001 at 11:20:47AM -0700, Tom Rini wrote:
>
> On Fri, Sep 21, 2001 at 11:49:51AM -0500, Peter Bergner wrote:
> >
> > Just a little nit, but some people might be interested, as part
> > of the "Various ppc64 & chrp fixes by Peter Bergner", we also
> > added support for booting compressed images (ie, zImage).
>
> As in objcopy ... && gzip -9 or the 'zImage' target?  They aren't exactly
> the same..

I've booted a zImage.rs6k-chrp from yaboot 1.2.5.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
