Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 082312C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 10:25:29 +1000 (EST)
Date: Tue, 10 Sep 2013 10:25:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tom Musta <tmusta@us.ibm.com>
Subject: Re: [PATCH] powerpc: OE=1 Form Instructions Not Decoded Correctly
Message-Id: <20130910102519.4c80a202cdc464c34402c03e@canb.auug.org.au>
In-Reply-To: <OF5204CF2E.B2F7FFF8-ON86257BE1.0044FF5E-86257BE1.0046077F@us.ibm.com>
References: <CAJ-hshaxuJBMCFquT7J50rjuDYWer_0i1=2QmnOKGAxx4n=FUw@mail.gmail.com>
 <20130908223559.GA495@iris.ozlabs.ibm.com>
 <1378721499.11525.5.camel@pasglop>
 <OF5204CF2E.B2F7FFF8-ON86257BE1.0044FF5E-86257BE1.0046077F@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__10_Sep_2013_10_25_19_+1000_y+Rh_23ulw0RIWTF"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Tom Musta <tommusta@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__10_Sep_2013_10_25_19_+1000_y+Rh_23ulw0RIWTF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On Mon, 9 Sep 2013 07:44:54 -0500 Tom Musta <tmusta@us.ibm.com> wrote:
>
> > Looks like the patch has been mangled by the mailer ... it's in HTML to
> > begin with :-)
>=20
> Frustrating.  I did use a plain text option on the mail client and did a
> test send to a few accounts before posting to the mailing list.  The
> patch was verified by checkpatch.pl before it got mangled.
>=20
> I will find a better setup and resubmit.

Also please find a mailer that does *not* respond to the envelope
recipient (linuxppc-dev-bounces+tmusta=3Dus.ibm.com@lists.ozlabs.org in
this case) as that just tends to irritate list owners.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
(slightly irritated list owner :-))

--Signature=_Tue__10_Sep_2013_10_25_19_+1000_y+Rh_23ulw0RIWTF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSLmbzAAoJEECxmPOUX5FE9AMP/AyCVkDTApKTyhedME6DCGdn
7IyGJAP2yXZw1oY+hsMPtJjl4eDAAWbW310ouxokCE+29ShOB0NMdrnfiQNyl3Fk
0lxTMTzSrZ7B52aGPSj5BiDW40Jhh2ldVciE4aarJU5cHu1FU4KMvmy1bWtHucQS
LigVNvD2BK2AZw4Q9Q/MFuw91N82IlhkTQisS332blz17UfX0xb1zaNqzoDn4M9P
Na95Z9N02E07F7WfXWK6322Zm8LFhVeIp05EZy1vQeL54/1Sb9gJ8Mjr75XqcEWD
bFpeUlUzr2Xkw9ougkAhcIto6+RYkUL/PD4eRrOx5b2XG5a08OjT5vPnKRAauXaW
Av5me/33u90CZ6+yFYL9mjk6OMzLn7vBdcmws4zcOFN4f6QObj2GYgaCZQ2KCjtc
gKp/uQLyQ9nwuEIebykd1e0U5wabUhiSbLnzhc6Pkp7K8GrOzvn9aBZbolwOT1+o
tKvmt8ZBjqWHOBDHHVWFDsBnncPKhjuHab+eV2z6dL7oXFpi2F8rPCbet1k2ZZmM
qu9dVgGurBhhaPBrKGSl92cd4FEcxTEMUIwZM0VTHTHtt6YJWK8Jd7fBw5nOKQL6
pXiuLsdxj1ITEfpxXlwS2cUXxNVzLCb0zVxR2AyRese+f75VsAsVlHGSvZ5AA7tX
VVCKeKhI6Pb0o2oMhVEc
=j8FK
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Sep_2013_10_25_19_+1000_y+Rh_23ulw0RIWTF--
