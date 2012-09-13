Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 5A8D62C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 22:37:41 +1000 (EST)
Date: Thu, 13 Sep 2012 22:37:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] pseries: double NR_CPUS in defconfig
Message-Id: <20120913223739.48f27d7fbacca32b013777fc@canb.auug.org.au>
In-Reply-To: <20120912174706.GE9269@linux.vnet.ibm.com>
References: <20120912174706.GE9269@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__13_Sep_2012_22_37_39_+1000_V_T/Od_UNWCIe4HE"
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__13_Sep_2012_22_37_39_+1000_V_T/Od_UNWCIe4HE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 12 Sep 2012 10:47:07 -0700 Nishanth Aravamudan <nacc@linux.vnet.ibm=
.com> wrote:
>
> Anticipating growth in coming years, we should ensure we are getting a
> good lead on testing.

Most changes to pseries_defconfig are copied into ppc64_defconfig.
Should this one be as well?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__13_Sep_2012_22_37_39_+1000_V_T/Od_UNWCIe4HE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQUdOTAAoJEECxmPOUX5FEZ84QAJSc/fYxXjKQcJsWKyMItdhI
cGoAlnJE+l5OTTFfrxxnxDnNslD3D67UQ0AmANyjPAPnJqMsacbUEmK5RY7CUyln
wf/DmmeXfz6oyO6R9zO/9QOxI0oIZBr5vIeFu/do6/iq8LmyUrr5xJNpaAbg33m9
UxCKSXWCil483KgzURPpdH3kgXhhKyfY3351BXAtzoz/JmtGXkvRraj9R3m19nMR
Slx0ja92pXXrx3hh0CavJAD9RIPd5x9xMeKYhRMN0j6xLMSfZTZBeNZLjLhWQ6Df
HscBeKlhP3wJIPC9WzAN/FdghFJ2Yy8lWUPqSK8BQRYRhibMgV+0Jb2aRbM5F2mk
cPUtoVSRVyhgYN0OvXCIvVXtoh4CfGdimOsWOzLSLxVMP4JcNOBhFe1C8sA8ULaF
Iwu7Y0mF76fzfk4vlTjfuDDRq/PHEGEelOdJ2NT1KLnV4UqUX5e3CaINFUMNm8aC
wGO9AHj2rdbgItlXnmdkFSkxR/HOhC0j2/tr6muw00SUsS3ERyV+w51VGcaOeUrh
VFQGkSOy3Jh/lEeGt1y22wWj3i5B1me2X9fVuqlr8oGQE2qlYwR/MzOFNsQSmOCo
tapyo9HJEkRc4Wdiwgq4IXmQisVl3jC464qaQjTa65uKCOXGxdVgCjGlN73nXwXL
14AurKjPJCinBapc4pEE
=mKGX
-----END PGP SIGNATURE-----

--Signature=_Thu__13_Sep_2012_22_37_39_+1000_V_T/Od_UNWCIe4HE--
