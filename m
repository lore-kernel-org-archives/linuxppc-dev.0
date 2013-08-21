Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id E27432C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 11:13:34 +1000 (EST)
Date: Wed, 21 Aug 2013 11:13:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Kconfig: Remove hotplug enable hints in CONFIG_KEXEC
 help texts
Message-Id: <20130821111323.1325e3f37faf2f54f3549832@canb.auug.org.au>
In-Reply-To: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
References: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__21_Aug_2013_11_13_23_+1000_GADke1ldKgHjpl8v"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__21_Aug_2013_11_13_23_+1000_GADke1ldKgHjpl8v
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, 20 Aug 2013 21:38:03 +0200 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
> commit 40b313608ad4ea655addd2ec6cdd106477ae8e15 ("Finally eradicate
> CONFIG_HOTPLUG") removed remaining references to CONFIG_HOTPLUG, but miss=
ed
> a few plain English references in the CONFIG_KEXEC help texts.
>=20
> Remove them, too.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks good to me.  Thanks.

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__21_Aug_2013_11_13_23_+1000_GADke1ldKgHjpl8v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSFBQ4AAoJEECxmPOUX5FETsMP/3VZR2oZGvtk3dTQaWWzB2dD
EkosPsIrqso9g4eHsEBYlDjZ8v45CKoTbp6kbV05x8YWsE+76NWWs6ey8jjoi9Cn
sSUvUjJ+PuNWGEjM2lsNDIAOfEdcudUVCfTv6aImxGcgCNz4KI0sbxtbWsi9yhlY
qwQJYtIjxv9gwb3f/gmdEfiyIsTMZPeBslrvWZLhM8yqi1iIFUntRFW8faX4UWAm
VP9WC92xExfClmaA+jb9iv7bwIB0wsyLMC9v2PipkaWIl5DxAi1f9O1TqlWQUCAE
FSzsvHl2iwB0vwPRzBSeB+VbJZxVtH9VHqVu3vrZWvPmFMZH00P4l6jkxgH/yUiK
EBNVKCOUpZyOpBaZ7DYVd6IR8V32LUFysQQijbE81YM+8d/D5JAOUlMu10I8Bzsq
sWZAe0Yn+tn7uhjIjG/HImewVnxwNjKwWqB258Wo7uvb0ku9+FPstFocAkNtKp3B
R9wt/F22neliAI5JwuBsd8YE0mJG/MUJNjkJ6Whq+CDzsTZnqGAcvlMin2Tazc3J
IjCz7Yjn63Pjv9spNvtTdotrzMalNRM7SSG/u7IvR505KYB1VcxL51AYCDnyAtUl
gLOzWvSxyeq6c1XTr/vO+SKs98Sn0ONl+tlMMgaX04XkWx79qYBKOVlmpqfoiZgK
ppDQ3M3O70TzO+fk5hNp
=3DQN
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Aug_2013_11_13_23_+1000_GADke1ldKgHjpl8v--
