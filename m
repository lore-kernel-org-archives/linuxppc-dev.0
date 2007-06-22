Return-Path: <Martin.Leisner@xerox.com>
Received: from wbmler3.mail.xerox.com (wbmler3.mail.xerox.com [13.13.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler3.mail.xerox.com",
	Issuer "wbmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 306D2DDED9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jun 2007 04:09:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: version control for dts/dtb?
Date: Fri, 22 Jun 2007 14:08:43 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C066B5B1F@usa0300ms03.na.xerox.net>
In-reply-to: <1182533095.29873.30.camel@ld0161-tx32>
References: <000301c7b03e$0e2a42a0$9700a8c0@hplaptop>
	<1182533095.29873.30.camel@ld0161-tx32>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: "Jon Loeliger" <jdl@freescale.com>, "marty" <leisner@rochester.rr.com>
Cc: "Lund, Nathan" <Nathan.Lund@xerox.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I made a node "revision" which was tied into rcs...

 ...
        compatible =3D "mpc74xx";
        revision =3D "$Revision: 1.7 $";
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        linux,phandle =3D <100>;
...

This seems to do what I wanted, I can then see in /proc/device-tree what
dts I'm running...

marty
> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozl
> abs.org] On Behalf Of Jon Loeliger
> Sent: Friday, June 22, 2007 1:25 PM
> To: marty
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: version control for dts/dtb?
>=20
> On Sat, 2007-06-16 at 12:44, marty wrote:
> > Is there a  wy to figure out the version of the dtb file I'm  using?
> > At a minimum, it would be useful to have a node with the=20
> conversion time=20
> > stuck somewhere...
> >=20
> > I ran dtc to convert binary to source, but that isn't=20
> necessarily what I=20
> > wanted to look at -- just a single date
> > code would be sufficient...
> >=20
> > marty
>=20
>=20
> There is currently no direct version stamp in the
> DTS or DTB files.  You may be able to derive some
> knowledge by running a DTB file through the DTC
> with the input file as "dtb" and looking at an
> output file of DTS, though.  That is, "-I dtb -O dts"
> and looking at it.
>=20
> HTH,
> jdl
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
