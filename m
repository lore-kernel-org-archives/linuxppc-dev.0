Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26C1C679FD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 09:11:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Viable PPC platform?
Date: Tue, 9 May 2006 16:11:15 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE028A43F3@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > -----Original Message-----
> From: Eugene Surovegin [mailto:ebs@ebshome.net]=20

> > > In message <20060509171520.GA10886@gate.ebshome.net> you wrote:
> > > >
> > > > After many years of doing embedded Linux stuff I still don't=20
> > > > understand why people are so fond of initrd.
> > > >=20
> > One size does not fit all.  We have an application with a very large
> > file system.  It can't fit in the available flash, however=20
> we do have a
> > ton of RAM (512MB).  NFS is not an option nor is it=20
> desirable (latency
> > and availability issues).  Boot time is not an issue either=20
> in this case
> > as it takes the equipment many minutes to calibrate and initialize.
> >=20
> > initrd also solves another problem.  The combined uBoot multi-image
> > although huge (>32 MB) represents a complete system=20
> firmware snapshot in
> > a single (huge) file.  By selecting the appropriate uImage=20
> the host can
> > guarantee the linux build, device drivers, application=20
> version and FPGA
> > firmware revs (the embedded board is rebooted to guarantee=20
> a repeatable
> > starting state).  This makes revision control for the overall system
> > much easier, especially since the host system is running windoze.
>=20
> This all is nice provided you use network for boot. IMHO this=20
> is quite=20
> _rare_ setup (especially Windows host!!!). For 99% of=20
> embedded designs=20
> this is obviously not a viable option.
>=20
> --=20
> Eugene

Again, I agree.  I just wanted to show you at least one case where
initrd is the best solution, IMHO.

As for a linux board booting off of a windoze host I prefer to think of
it as an island of sanity in a sea of chaos.

Marc W. Howard
