Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 823FD2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 17:46:40 +1000 (EST)
Date: Fri, 28 Jun 2013 17:46:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/eeh: Update MAINTAINERS
Message-Id: <20130628174634.3d05e076cbe48ffc4ad67a60@canb.auug.org.au>
In-Reply-To: <1372398143-15561-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372398143-15561-1-git-send-email-shangw@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__28_Jun_2013_17_46_34_+1000_222C8ciHv7uHCAnL"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__28_Jun_2013_17_46_34_+1000_222C8ciHv7uHCAnL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gavin,

On Fri, 28 Jun 2013 13:42:23 +0800 Gavin Shan <shangw@linux.vnet.ibm.com> w=
rote:
>
> Update MAINTAINERS to reflect recent changes.
>=20
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5be702c..78e64c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6149,7 +6149,13 @@ M:	Linas Vepstas <linasvepstas@gmail.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.txt
> +
> +ENHANCED ERROR HANDLING (EEH)
> +M:	Gavin Shan <shangw@linux.vnet.ibm.com>
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
> +F:	arch/powerpc/kernel/eeh*.c
> =20
>  PCI SUBSYSTEM
>  M:	Bjorn Helgaas <bhelgaas@google.com>

The entries in the MAINTAINERS file are meant to be in alphabetical
order ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__28_Jun_2013_17_46_34_+1000_222C8ciHv7uHCAnL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRzT9eAAoJEECxmPOUX5FEevIQAJ/2KviWbhD9oAxwp5xA7bPp
wdMlpcrUSFNkZMzI7Wy8o8B2liXXBLx1dQmtfbMqu1iw2+O3smpoNRqVL6W71KxV
I7gHqAM1KzWNRBM2zrf2G6j6gNnbZ/A166HC6nxAAU0XgBg1qVVqWWdWY4dGpb55
a4rgRjFHeJkjSL+s+DZ09ti4QTdqiDx0zGIIDom77279SuMrGIsR7d+P5+v/Slmm
2u8HbJpP+FUvrHbVejyaAGJdscqmwMkPlieVjeIg31WpVpQwYRYnjC0VFkeOLC4Z
lLvIEWar6vDcrgN1Ki4VFT9e7qT2ILPlr9hlp/2n0W0rcwKNYw9qXF/InwuzyFtY
iYIgmmt38H20Tqj8BakzjU4eMj/UMkVdRvSYe9q2xtSPkMiwI5i86t+vEn8/KGRg
KQR4XaQmP0ai0HRkjGy/Cd0is+ZK1MssHpozAoxYS0vuYT1/hoevUoErON0W+TkX
g1qzqhpIVJe1m8pbVQWK5TPDc+HONBzL7USV7c4Wy9120e5XXzCqFm9qPbm5dsND
422uTZHh5VChlfY2wvvLLV4vlunq/7WMW1ab8X5zZBSP38Jf3rOhsJmlOvzAF0MH
CWZRgawjeCNGohThely39z+RcTkTS7K3sfaT7qIoSxzU68Ni7TqTatzL5kRbg8yz
jpKAWm+nDRCbHb/GMpxo
=Fn9P
-----END PGP SIGNATURE-----

--Signature=_Fri__28_Jun_2013_17_46_34_+1000_222C8ciHv7uHCAnL--
