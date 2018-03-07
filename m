Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwzl32cfQzF1c3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 14:33:51 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w273Scsl015239
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 22:33:48 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gj4ru6knt-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 22:33:48 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 7 Mar 2018 03:33:46 -0000
Date: Wed, 7 Mar 2018 14:33:39 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 9/9] powerpc/eeh: Add eeh_state_active() helper
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <2c6264797f9efd44679fa8c8ac4f8beb11a38c18.1520294174.git.sam.bobroff@au1.ibm.com>
 <1520315388.2077.15.camel@russell.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <1520315388.2077.15.camel@russell.cc>
Message-Id: <20180307033338.GA4666@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 04:49:48PM +1100, Russell Currey wrote:
> On Tue, 2018-03-06 at 11:00 +1100, Sam Bobroff wrote:
> > Checking for a "fully active" device state requires testing two flag
> > bits, which is open coded in several places, so add a function to do
> > it.
> >=20
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
>=20
> Thanks for the patches.

Thanks for the review, I'll do a v2 with all the nits mentioned so far,
Sam.

> Reviewed-by: Russell Currey <ruscur@russell.cc>


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlqfXYoACgkQMX8w6AQl
/iKLfggAiejRQc0h6WuWI2QfttTU3DSOz0gFR9HedcX/SPXodlVKBm+fN92q3b6m
uu5Ir4oY13xFMNGaa+tDsVKQ7IR4/m6g/QnRYJDt8d89hVeiS70TnXceRMOEU+ts
M9xE0fSmuyFbUT3tE+2ezsiNs/HlrDcT6YnlAwtDxK6eem8/leiG0tJqQPcW26Ti
VsOfV3zoOUwoyjlDWwGmHjRf9aBRfwKgrfEgyyX50Ad5SQBHcaTG5jYZdszZzDc0
chtXcQC/DpMv8DMNIwcWBmhEGtFaXcVGDLwgNPzHX1ppqq8qSPVJt4IFYZYStpkS
vr23T45t2Uu3f4QO5AjAsyTPtMfSXQ==
=Zf1G
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
