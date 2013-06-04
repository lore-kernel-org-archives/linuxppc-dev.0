Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 4 Jun 2013 10:01:30 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Robert Knight <knight@princeton.edu>
Subject: Re: IBM OpenPower 720 ipr driver woes
Message-ID: <20130604000130.GA25055@thor.bakeyournoodle.com>
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com>
 <51AD088C.8040803@princeton.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
In-Reply-To: <51AD088C.8040803@princeton.edu>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Wendy Xiong <wenxiong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Jun 03, 2013 at 05:20:12PM -0400, Robert Knight wrote:

> >Device tree struct  0x0000000004820000 -> 0x0000000004840000
> >Calling quiesce...
> >returning from prom_init
> >[    1.376359] ehci-pci 0000:c8:01.2: can't setup

Can you try adding "debug" to the kernel commandline.  We're missing a
great chunk of detail. If you're starting from scratch either try F18 or
the F19 Beta (if you're brave :))

Yours Tony

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBCAAGBQJRrS5aAAoJEEsCiJRY75GKmhgQAMRielIxBLDMWUDyL21acuOe
C3rDWHzqexK/V2Hzn19K5J21woVBdFCCKlCdkeOfPqd/wk6Kns8L1DqZ3Vj/C+Ij
SQL6JCMauKzs7hDOME8NIfVSBWkjosi8U0tErdQU8FjzINgmeWreUP1D4jpqABvm
eqvW8JSC3j2apVVNlUfMm6t5yn3al/1zq9/SxpwNOmFo0jW8pVvg0jC0/K69aH3R
l7AmgoSUWFWwIWqYAroPVZYJvAtUkIZ+g7ae++/66KX3A+/luTaVbNJHEUH+5Sq/
Anfqq8voIAlcEM6HWUAgtCWhAa7XpIdMFjwtMNnCVh8P4+ob+Tu2tbJnz0xS3x//
HgxlfMX0Kpi6PdB0teW6sORPTPcsJh5N909PTQTbtxpvyAhVDgUBfON+z4bn5vv9
VNLDvFhnpCeu00Yg0LBOye9HRIWiZzz4aLT7pmoRoWauwbHquqFsUywNIwT2T088
HpUgbmcdIM7jBxHbTUhkFpS/+QM1ULOgkEFw/bEsHlsKqoTjLPSCXhKWVDw3NjNx
s4NCC9CV8gnk2HRoJLdmBvHvI18CgPjkqAIfXazYQBrZpJSLwGI42vWcPDagHlb5
AGAbrBHPasTVN/5mVRzN3QM9eVYRfkmU6MdMdEtcDAYuWj51PgA9MY17sl6OU//5
RXEZLYc2mIM/VRRviZ09
=VPlg
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
