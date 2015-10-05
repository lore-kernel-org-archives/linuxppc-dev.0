Return-Path: <marvin24@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCF7F1A0239
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Oct 2015 21:34:15 +1100 (AEDT)
From: Marc Dietrich <marvin24@gmx.de>
To: Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Time to remove platforms/cell?
Date: Mon, 05 Oct 2015 12:27:50 +0200
Message-ID: <2232594.bcXLTZgZyv@fb07-iapwap2>
In-Reply-To: <1443986839.20459.8.camel@infradead.org>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <2785247.ZjG8XMQlJP@fb07-iapwap2> <1443986839.20459.8.camel@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1946704.QmF4Xtv5Uk";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart1946704.QmF4Xtv5Uk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Geoff,

Am Sonntag, 4. Oktober 2015, 12:27:19 schrieb Geoff Levand:
> Hi,
> 
> On Thu, 2015-09-17 at 12:28 +0200, Marc Dietrich wrote:
> > well, I like to but I couldn't get the kernel booting for some reason.
> > Still trying.
> 
> I just tested the ps3-queue branch (v4.3-rc4 based) of my ps3-linux git
> repo and it works OK.
> 
> Do you see any output on the display, maybe some penguins at least


I tried with ps3-queue and still no luck. Petitboot just says "Booting kernel 
..." thats all - no output.

FW is 3.15 of course
Petitboot says (white-09.09.01-15.56)
compiled kernel with gcc 4.4.2 (fedora 13)
git clean -fdx; make ps3_defconfig; make vmlinux modules; make modules_install
strip --strip-unneeded vmlinux
boot this kernel

Maybe still something missing?

Thanks!

Marc
--nextPart1946704.QmF4Xtv5Uk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWElCmAAoJEKyeR39HFBtoCo8H/22adItjuoAdqOU4AUwrcLkg
PPo8HvpamTKXfbFfsXl4Gx74dZOhxvI7xigTdJzyqJ9wH6u5TKHreiqnXLjsjw9W
UwN8/Rsu7z1dqYW/BB7fDTRczJsZ76vXZM85mzryDgHJs1lhmkC7AKDjm39EPwPs
04NG34v6viPiXvcWel2CYNEhi7fvzcOSAM+MSEDQJaHrIMj5yamYhjab54bP3/iD
BODUUHHGPDeYrO33j1fQyJ5aZOJGnHrcmvxjZ2WxFmwq15vrRFwiuGVd2XC7sPat
UMbq4RwL9EUlftqiOnmICqqdyJnrqSexgWcESMg7tEHYWe1Z4ItOvBd9JjgGZhU=
=V4DO
-----END PGP SIGNATURE-----

--nextPart1946704.QmF4Xtv5Uk--
