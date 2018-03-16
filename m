Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402z732BZpzF1X6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 08:26:55 +1100 (AEDT)
Date: Sat, 17 Mar 2018 08:25:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: dtc warnings
Message-ID: <20180317082545.3074a84d@canb.auug.org.au>
In-Reply-To: <87r2okglbj.fsf@concordia.ellerman.id.au>
References: <20180314161854.51b994ff@canb.auug.org.au>
 <87r2okglbj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sMnW9OFgsUuiFscV+_OVDhT"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/sMnW9OFgsUuiFscV+_OVDhT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Sat, 17 Mar 2018 01:13:36 +1100 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>=20
> > I get the following from a powerpc_ppc44x defconfig build in current
> > linux-next:
> >
> > arch/powerpc/boot/ebony.dtb: Warning (pci_bridge): /plb/pci@20ec00000: =
missing bus-range for PCI bridge
> > arch/powerpc/boot/ebony.dtb: Warning (pci_device_bus_num): Failed prere=
quisite 'pci_bridge'
> > arch/powerpc/boot/ebony.dtb: Warning (chosen_node_stdout_path): /chosen=
:linux,stdout-path: Use 'stdout-path' instead
> > arch/powerpc/boot/sequoia.dtb: Warning (pci_bridge): /plb/pci@1ec000000=
: missing bus-range for PCI bridge
> > arch/powerpc/boot/sequoia.dtb: Warning (pci_device_bus_num): Failed pre=
requisite 'pci_bridge'
> > arch/powerpc/boot/sequoia.dtb: Warning (chosen_node_stdout_path): /chos=
en:linux,stdout-path: Use 'stdout-path' instead
> > arch/powerpc/boot/sam440ep.dtb: Warning (pci_bridge): /plb/pci@ec000000=
: missing bus-range for PCI bridge
> > arch/powerpc/boot/sam440ep.dtb: Warning (pci_device_bus_num): Failed pr=
erequisite 'pci_bridge'
> > arch/powerpc/boot/sam440ep.dtb: Warning (chosen_node_stdout_path): /cho=
sen:linux,stdout-path: Use 'stdout-path' instead
> > arch/powerpc/boot/rainier.dtb: Warning (pci_bridge): /plb/pci@1ec000000=
: missing bus-range for PCI bridge
> > arch/powerpc/boot/rainier.dtb: Warning (pci_device_bus_num): Failed pre=
requisite 'pci_bridge'
> > arch/powerpc/boot/rainier.dtb: Warning (chosen_node_stdout_path): /chos=
en:linux,stdout-path: Use 'stdout-path' instead
> > arch/powerpc/boot/taishan.dtb: Warning (pci_bridge): /plb/pci@20ec00000=
: missing bus-range for PCI bridge
> > arch/powerpc/boot/taishan.dtb: Warning (pci_device_bus_num): Failed pre=
requisite 'pci_bridge'
> > arch/powerpc/boot/taishan.dtb: Warning (chosen_node_stdout_path): /chos=
en:linux,stdout-path: Use 'stdout-path' instead
> > arch/powerpc/boot/bamboo.dtb: Warning (pci_bridge): /plb/pci@ec000000: =
missing bus-range for PCI bridge
> > arch/powerpc/boot/bamboo.dtb: Warning (pci_device_bus_num): Failed prer=
equisite 'pci_bridge'
> > arch/powerpc/boot/bamboo.dtb: Warning (chosen_node_stdout_path): /chose=
n:linux,stdout-path: Use 'stdout-path' instead
> > arch/powerpc/boot/katmai.dtb: Warning (pci_bridge): /plb/pciex@d0000000=
0: node name is not "pci" or "pcie"
> > arch/powerpc/boot/katmai.dtb: Warning (pci_bridge): /plb/pciex@d2000000=
0: node name is not "pci" or "pcie"
> > arch/powerpc/boot/katmai.dtb: Warning (pci_bridge): /plb/pciex@d4000000=
0: node name is not "pci" or "pcie"
> > arch/powerpc/boot/katmai.dtb: Warning (pci_device_bus_num): Failed prer=
equisite 'pci_bridge'
> > arch/powerpc/boot/katmai.dtb: Warning (chosen_node_stdout_path): /chose=
n:linux,stdout-path: Use 'stdout-path' instead
> > arch/powerpc/boot/warp.dtb: Warning (chosen_node_stdout_path): /chosen:=
linux,stdout-path: Use 'stdout-path' instead
> > arch/powerpc/boot/yosemite.dtb: Warning (pci_bridge): /plb/pci@ec000000=
: missing bus-range for PCI bridge
> > arch/powerpc/boot/yosemite.dtb: Warning (pci_device_bus_num): Failed pr=
erequisite 'pci_bridge'
> > arch/powerpc/boot/yosemite.dtb: Warning (chosen_node_stdout_path): /cho=
sen:linux,stdout-path: Use 'stdout-path' instead
> >
> > I though someone might like to do something about them ... =20
>=20
> Feel free!
>=20
> Oh that's not what you meant :P

:-)

> Rob sent a patch to fix most of them:
>   http://patchwork.ozlabs.org/patch/879475/
>=20
> I thought he was going to merge it, but actually I'm not sure why I
> thought that. So I should probably merge it.

excellent, thanks

--=20
Cheers,
Stephen Rothwell

--Sig_/sMnW9OFgsUuiFscV+_OVDhT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqsNlkACgkQAVBC80lX
0GyU0AgAoWdap+yq/YkG23fkdEYtASgVp/MhU1dzW1R9KZ8bBfKmHyVkk9LJNgxX
wRCgu0mi6DVsfv+p57OKA5cWgalZcHWl4XjZTYumuoCClrrKq9An7PKKevd3TzOA
KRcUv/Cemg4reQ9C3bguNuDR5DKKndRcuvlInUlYVnOE/UpUzasia66GxbmavnPG
ajdIpmkscg/2Pq+K8lTQ2aLliTKV+PatUs4308f0rp0MlWjqp47mXeeB1O2dY2P7
ZZD/ToAKsrFwNx3TaaP3Hkf4jG+IZsUttP/OaZQxJLcBKRmLJ+1W6eznMeY2hWDU
6jY6jLlsIDrvJuqNMRw5YQERhwdKNQ==
=OTgo
-----END PGP SIGNATURE-----

--Sig_/sMnW9OFgsUuiFscV+_OVDhT--
