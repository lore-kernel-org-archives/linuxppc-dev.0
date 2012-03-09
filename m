Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 18279B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 12:32:25 +1100 (EST)
Date: Fri, 9 Mar 2012 12:32:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: linux-next: manual merge of the pci tree with the powerpc tree
Message-Id: <20120309123216.82d231febae9ce73bc59f9b2@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__9_Mar_2012_12_32_16_+1100_3B0z1Ne=Q0.3qtL8"
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__9_Mar_2012_12_32_16_+1100_3B0z1Ne=Q0.3qtL8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

Today's linux-next merge of the pci tree got a conflict in
arch/powerpc/platforms/iseries/pci.c between commit 8ee3e0d69623
("powerpc: Remove the main legacy iSerie platform code") from the powerpc
tree and commit 673c97562489 ("powerpc/PCI: replace pci_probe_only with
pci_flags") from the pci tree.

The former removed the file, so I did that.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__9_Mar_2012_12_32_16_+1100_3B0z1Ne=Q0.3qtL8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPWV2gAAoJEECxmPOUX5FEfOkQAJaKjqvQy+NIHbavLw2+Oqgv
MMV/Txj3SqTKAD/8d0jOuPiJZzf9oKJy2J3997XVsUc7AInGcyFQDCRNpvIMoCqT
3if91plX4k3vMnbCmfPNRL1/Ykiq6tEkv1V0Yriq35ynv6gcgHrPAV8IRclA6/89
zQYbFMHveDqJCbiIDFhMqTVSwVrXvAigg+dNYbYxeXYxxZ2SaaJvJbVXURfl4zyP
lIMqK/Vjd4gKFuSLD7gmKReduTt6XIpwHxXsKkPlr3q5m5shXhERi9s0LG1gFUYe
AJDxS2LtS45ZXFvri+Xx2d2EyiCF80APmEZ8hu/v/SLZ6e7FyqKG6luE5QX+svbE
wL2Lkc6x3EC9XrOqjeXtxt86L1pwg7XnSTA9CoQqPbDj0hwK+ILQhI/yrgNnwVTd
fzOk9m+vL0YPGUxTSPee+2E8Iu9FUWXillmbZjTGA+5lzjVtL0gqfOo2epPIQnc2
Ln5bLDdwj2JLfl9th8OMNg1NZyLngaxaePGedngzo7JqwIDklVkNIly4FxURqPTS
1E6uf/3lXBYt+2r8Ja2L9s0vowlIEqfn2XjGKzDu4Gn5LouvOXDhMV0cGziA14C8
09f+DGLXfcOuOiM7pkWKoCsLPAJ//eyhg65nPgz+opp+tjQTKXI+4yz/pcEfhJ68
KWg3sHdQD2t4R4NZj6YC
=iUuf
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Mar_2012_12_32_16_+1100_3B0z1Ne=Q0.3qtL8--
