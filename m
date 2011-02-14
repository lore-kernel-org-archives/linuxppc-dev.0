Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 854FEB7184
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 19:55:57 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 10813-02 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 08:55:50 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
	InterfaceLayer
Date: Mon, 14 Feb 2011 08:53:21 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AC4D@saturn3.aculab.com>
In-Reply-To: <4f99d54a42d4f13663c88b0b081f047b@mail.gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Tirumala Marri" <tmarri@apm.com>, "Greg KH" <greg@kroah.com>,
	"Alexander Gordeev" <lasaine@lvk.cs.msu.su>
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > Sorry, I don't understand that. I think u32 is always 32bit=20
> > 4byte on all archs. Right?
>=20
> Yes.
>=20
> Use an unsigned long if you want to hold a pointer correctly on all
> arches.

Although that is true for many systems (and probably all ppc Linux)
it isn't necessarily true (eg 64 bit Microsoft Windows).
C99 inttypes.h should define uintptr_t as an unsigned integer
type that is large enough to hold a (data) pointer.
I'm not sure if this is defined for the Linux kernel.

	David
