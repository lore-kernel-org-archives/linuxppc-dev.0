Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE002.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 0C6AADDFF6
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 06:27:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Microblaze init port v4
Date: Thu, 26 Jun 2008 13:27:29 -0700
In-Reply-To: <20080626194301.GD22827@cs181140183.pp.htv.fi>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<20080626150121.GB22025@cs181140183.pp.htv.fi>
	<4863E4FD.6040803@seznam.cz>
	<20080626194301.GD22827@cs181140183.pp.htv.fi>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Adrian Bunk" <bunk@kernel.org>,
	"Michal Simek" <monstr@seznam.cz>
Message-ID: <20080626202730.CEE063C0061@mail98-va3.bigfish.com>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com,
	John Linn <linnj@xilinx.com>, drepper@redhat.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We're looking at putting a microblaze toolchain on git.xilinx.com, which
will be slightly easier than grabbing all of petalinux, if people just
want to compile test it.  =


At the moment, we would very much like to push the microblaze
architecture code to the gcc mainline.  I believe the main barrier is
that we don't have someone with the bandwidth to interact with the gcc
community at the moment, although hiring someone to work on it may be in
the works. (Anyone interested?)

Steve

> -----Original Message-----
> From: Adrian Bunk [mailto:bunk@kernel.org]
> Sent: Thursday, June 26, 2008 12:43 PM
> To: Michal Simek
> Cc: linux-kernel@vger.kernel.org; arnd@arndb.de;
linux-arch@vger.kernel.org; Stephen Neuendorffer;
> John Linn; john.williams@petalogix.com; matthew@wil.cx;
will.newton@gmail.com; drepper@redhat.com;
> microblaze-uclinux@itee.uq.edu.au; grant.likely@secretlab.ca;
linuxppc-dev@ozlabs.org;
> vapier.adi@gmail.com; alan@lxorguk.ukuu.org.uk; hpa@zytor.com
> Subject: Re: Microblaze init port v4
> =

> On Thu, Jun 26, 2008 at 08:50:37PM +0200, Michal Simek wrote:
> > Hi Adrian,
> >
> > > On Thu, Jun 26, 2008 at 02:29:29PM +0200, monstr@seznam.cz wrote:
> > >> Hi everybody,
> > >>
> > >> current linux version is 2.6.26-rc8 and I think this is the right
time
> > >> to send latest patches againts rc8 for Microblaze CPU.
> > >> ...
> > >
> > > Thanks for your work on getting the architecture included.
> > >
> > > I have two questions:
> > >
> > > Where can I find a toolchain for compiling a Microblaze kernel?
> > I personally use petalogix toolchain from www.petalogix.com.
> >
> > > What is the status of Microblaze support in upstream binutils and
gcc?
> >
> > I don't have any information about. We will discuss with John
Williams and guys
> > from Xilinx
> > what we can do for it.
> =

> Thanks!
> =

> > M
> =

> cu
> Adrian
> =

> --
> =

>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
