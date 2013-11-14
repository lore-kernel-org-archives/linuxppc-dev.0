Return-Path: <monstr@monstr.eu>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DF6B2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 20:40:15 +1100 (EST)
Received: by mail-wg0-f50.google.com with SMTP id k14so1630846wgh.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 01:40:10 -0800 (PST)
Message-ID: <52849A65.9030500@monstr.eu>
Date: Thu, 14 Nov 2013 10:39:49 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 00/11] Consolidate asm/fixmap.h files
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
 <52824BBC.9020401@monstr.eu> <1384271711.24631.5.camel@deneb.redhat.com>
In-Reply-To: <1384271711.24631.5.camel@deneb.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="iQtiGn9GE0PIJmOHe35N72OtEjLmxDLif"
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 James Hogan <james.hogan@imgtec.com>, Russell King <linux@arm.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, microblaze-uclinux@itee.uq.edu.au,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iQtiGn9GE0PIJmOHe35N72OtEjLmxDLif
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/12/2013 04:55 PM, Mark Salter wrote:
> On Tue, 2013-11-12 at 16:39 +0100, Michal Simek wrote:
>> On 11/12/2013 02:22 PM, Mark Salter wrote:
>>>
>>>  arch/arm/include/asm/fixmap.h        |  25 ++------
>>>  arch/hexagon/include/asm/fixmap.h    |  40 +------------
>>>  arch/metag/include/asm/fixmap.h      |  32 +----------
>>>  arch/microblaze/include/asm/fixmap.h |  44 +-------------
>>>  arch/mips/include/asm/fixmap.h       |  33 +----------
>>>  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
>>>  arch/sh/include/asm/fixmap.h         |  39 +------------
>>>  arch/tile/include/asm/fixmap.h       |  33 +----------
>>>  arch/um/include/asm/fixmap.h         |  40 +------------
>>>  arch/x86/include/asm/fixmap.h        |  59 +------------------
>>>  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++=
++++++++++
>>>  11 files changed, 125 insertions(+), 371 deletions(-)
>>>  create mode 100644 include/asm-generic/fixmap.h
>>
>> Any repo/branch with all these patches will be helpful.
>=20
> https://github.com/mosalter/linux (fixmap branch)

Thanks,

For Microblaze
Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--iQtiGn9GE0PIJmOHe35N72OtEjLmxDLif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKEmmUACgkQykllyylKDCF4AQCgjhFOcr0jquPeAeSfJ6XEBDsZ
dTIAn2jGHts/85REgK0/IHvrLywyWO8a
=ZN3C
-----END PGP SIGNATURE-----

--iQtiGn9GE0PIJmOHe35N72OtEjLmxDLif--
