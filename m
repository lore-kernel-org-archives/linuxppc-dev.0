Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 2B4112C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 09:05:09 +1100 (EST)
Date: Tue, 13 Nov 2012 09:05:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v3.7-rc5
Message-Id: <20121113090501.8a93b5bb08518f897acddf41@canb.auug.org.au>
In-Reply-To: <CAMuHMdXE0yJNivpirGgx08zqLH2086ydeOU6zswXj-+zn8OsWQ@mail.gmail.com>
References: <1352753886-3402-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXE0yJNivpirGgx08zqLH2086ydeOU6zswXj-+zn8OsWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__13_Nov_2012_09_05_01_+1100_XhYe/dgMqqEhzt9x"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__13_Nov_2012_09_05_01_+1100_XhYe/dgMqqEhzt9x
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thanks for these reports!

On Mon, 12 Nov 2012 22:02:46 +0100 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
>   + error: relocation truncated to fit: R_PPC64_REL24 against symbol
> `._mcount' defined in .text section in arch/powerpc/kernel/entry_64.o:
> (.text+0x1ff9eb8) =3D> (.text+0x1ffa274), (.text+0x1ff7840)
>=20
> powerpc-allyesconfig

Yeah, as Scott said, these are not worth reporting.  However, they are
being worked on in various ways, but will probably not be solved very
soon (it means we have to change how we link the kernel and that will
probably require some discussion).

I just keep the powerpc allyesconfig build there to catch other stuff
(like drivers that assume too much).
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__13_Nov_2012_09_05_01_+1100_XhYe/dgMqqEhzt9x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQoXKNAAoJEECxmPOUX5FESKIP/3rgywvl5XY0vw+U594qGnZO
kp3eZssyk7EQEb38VOVSeIvlI+Ya5P+1i8Dw8z+zlDYcDsOA1h/+hjERLZH9ynAa
sT5s8lqupY2s4RZ4hmZlZUlrl0rhqrtUFT3PDxQRxoWju/VVJn8c+7d3Qthx6oHF
if+yy1IgGPcB+PRVC2urUR+TiDXAL7Qiumpn2vF1b+yRMN6dLrhRuRZP86O7yPLA
/T+6AILoUsUbwew+8RWAKiWm7PRmQa9Sc/14+gjRg+VFxIZF3izt6n8qYQiYDP3u
jgZZXbSLFDpC8MkIogMJYymXN7aAM+Qt/246NuL/ztPkbdkTeLhwbNqOGHQsvxMk
XzDR8Udrj8/s3dQoRc4Zpo+nSeBScvPMVrnvGJgdUGVXXJc116uOzK4jUL8LJQaE
DHCqmJYKBIzpI6L08b4McKPCcF1lrvQyuesT2ESjN0DIRPSJK0XIDdm0HsboUPNj
IzqU7sNkmhP2ldOsjh/pisGK2ww/RTEOj+hFUCM51YLxRgDFCts4+b6q6+Kgf2GS
CwtwEJVzWRqgBJnI8TbVIMTZoPVdEDxf2zrmEXYJgQhuf79e8zxIUEYfXJ4d2tLg
fvb9MWuRubQa9qb+zrsFDVuriNBA9TtszoTKG6trnYOK7MbHAaPm5BEYQIJkjrIk
DzPboLfTLVuXrFvn+Er9
=oZaS
-----END PGP SIGNATURE-----

--Signature=_Tue__13_Nov_2012_09_05_01_+1100_XhYe/dgMqqEhzt9x--
