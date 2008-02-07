Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 25767DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 11:10:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: System Clock runaway on Xilinx platform
Date: Wed, 6 Feb 2008 16:10:18 -0800
In-Reply-To: <15312437.post@talk.nabble.com>
References: <15312437.post@talk.nabble.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "khollan" <khollan@daktronics.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080207001020.0E2696E0075@mail129-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


The processor is an integer factor faster than the bus, unless you're
doing something really unusual.  Are you sure that's not 300 and 150?

175/150 =3D 1.16, which might be the difference you're seeing?

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of khollan
> Sent: Wednesday, February 06, 2008 11:42 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: System Clock runaway on Xilinx platform
>=20
>=20
> Hi all,
>=20
> Thanks for the help so far!
> I'm now running linux 2.6.21 on my custom virtex 4 board modeled after
the
> ml410.  The cpu clock is 300MHz and the PLB bus is 175MHz.
>=20
> My question is which clock is the linux system clock that keeps track
of the
> date derived from?  I set my date with rdate -s time.mit.edu at boot
and
> then compare with the date command and rdate -p time.mit.edu and they
are
> off by 20 or so seconds even just after a few minutes, this trend
continues
> and it will be off by a day after a few hours.  I think I just don't
have
> something defined correctly but I can't figure out which.
>=20
> Thanks
>=20
> Kevin
> --
> View this message in context:
http://www.nabble.com/System-Clock-runaway-on-Xilinx-platform-
> tp15312437p15312437.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
