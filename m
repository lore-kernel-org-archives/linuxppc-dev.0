Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401KlZ0hGxzF0yG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 16:19:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 401KlY4jbfz9sT9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 16:19:21 +1100 (AEDT)
Date: Wed, 14 Mar 2018 16:18:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: dtc warnings
Message-ID: <20180314161854.51b994ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3+Mz=5FDrJN8Npkin0xb5y3"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/3+Mz=5FDrJN8Npkin0xb5y3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,


I get the following from a powerpc_ppc44x defconfig build in current
linux-next:

arch/powerpc/boot/ebony.dtb: Warning (pci_bridge): /plb/pci@20ec00000: miss=
ing bus-range for PCI bridge
arch/powerpc/boot/ebony.dtb: Warning (pci_device_bus_num): Failed prerequis=
ite 'pci_bridge'
arch/powerpc/boot/ebony.dtb: Warning (chosen_node_stdout_path): /chosen:lin=
ux,stdout-path: Use 'stdout-path' instead
arch/powerpc/boot/sequoia.dtb: Warning (pci_bridge): /plb/pci@1ec000000: mi=
ssing bus-range for PCI bridge
arch/powerpc/boot/sequoia.dtb: Warning (pci_device_bus_num): Failed prerequ=
isite 'pci_bridge'
arch/powerpc/boot/sequoia.dtb: Warning (chosen_node_stdout_path): /chosen:l=
inux,stdout-path: Use 'stdout-path' instead
arch/powerpc/boot/sam440ep.dtb: Warning (pci_bridge): /plb/pci@ec000000: mi=
ssing bus-range for PCI bridge
arch/powerpc/boot/sam440ep.dtb: Warning (pci_device_bus_num): Failed prereq=
uisite 'pci_bridge'
arch/powerpc/boot/sam440ep.dtb: Warning (chosen_node_stdout_path): /chosen:=
linux,stdout-path: Use 'stdout-path' instead
arch/powerpc/boot/rainier.dtb: Warning (pci_bridge): /plb/pci@1ec000000: mi=
ssing bus-range for PCI bridge
arch/powerpc/boot/rainier.dtb: Warning (pci_device_bus_num): Failed prerequ=
isite 'pci_bridge'
arch/powerpc/boot/rainier.dtb: Warning (chosen_node_stdout_path): /chosen:l=
inux,stdout-path: Use 'stdout-path' instead
arch/powerpc/boot/taishan.dtb: Warning (pci_bridge): /plb/pci@20ec00000: mi=
ssing bus-range for PCI bridge
arch/powerpc/boot/taishan.dtb: Warning (pci_device_bus_num): Failed prerequ=
isite 'pci_bridge'
arch/powerpc/boot/taishan.dtb: Warning (chosen_node_stdout_path): /chosen:l=
inux,stdout-path: Use 'stdout-path' instead
arch/powerpc/boot/bamboo.dtb: Warning (pci_bridge): /plb/pci@ec000000: miss=
ing bus-range for PCI bridge
arch/powerpc/boot/bamboo.dtb: Warning (pci_device_bus_num): Failed prerequi=
site 'pci_bridge'
arch/powerpc/boot/bamboo.dtb: Warning (chosen_node_stdout_path): /chosen:li=
nux,stdout-path: Use 'stdout-path' instead
arch/powerpc/boot/katmai.dtb: Warning (pci_bridge): /plb/pciex@d00000000: n=
ode name is not "pci" or "pcie"
arch/powerpc/boot/katmai.dtb: Warning (pci_bridge): /plb/pciex@d20000000: n=
ode name is not "pci" or "pcie"
arch/powerpc/boot/katmai.dtb: Warning (pci_bridge): /plb/pciex@d40000000: n=
ode name is not "pci" or "pcie"
arch/powerpc/boot/katmai.dtb: Warning (pci_device_bus_num): Failed prerequi=
site 'pci_bridge'
arch/powerpc/boot/katmai.dtb: Warning (chosen_node_stdout_path): /chosen:li=
nux,stdout-path: Use 'stdout-path' instead
arch/powerpc/boot/warp.dtb: Warning (chosen_node_stdout_path): /chosen:linu=
x,stdout-path: Use 'stdout-path' instead
arch/powerpc/boot/yosemite.dtb: Warning (pci_bridge): /plb/pci@ec000000: mi=
ssing bus-range for PCI bridge
arch/powerpc/boot/yosemite.dtb: Warning (pci_device_bus_num): Failed prereq=
uisite 'pci_bridge'
arch/powerpc/boot/yosemite.dtb: Warning (chosen_node_stdout_path): /chosen:=
linux,stdout-path: Use 'stdout-path' instead

I though someone might like to do something about them ...
--=20
Cheers,
Stephen Rothwell

--Sig_/3+Mz=5FDrJN8Npkin0xb5y3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqosL4ACgkQAVBC80lX
0GwHNwf9EYOS77Y0uZ2VCBrSSGD+jYpDoSjeMG8fEtDpkFFOwXCb3TxqQFwZq5PR
6Wwtewgite8sdTqDkboU5Qm+9Xr/yBrpuzTCE8x4TzjYi0gwn0KK8jZDPoIObnBH
COQmn1VPccpIXXHYAWKnXYthdq45A/mwmlvKaLBC2WWroaAwfHMW8m4cX3Z40F2c
6jCJAJr83uimaezBsp8mrz4x1YVJ7s1qtDDzL0CukK44MKuKtkU1o25gkyFBmCQz
3c36AFMnErlUOmKG2PybkyKPd1JTdmrSorR2EBmhIXqSxLcBFpUIXgz2Tl5fk2+q
omWSsUrBIim2cBTLs7AN16HsWHUlPA==
=1iU4
-----END PGP SIGNATURE-----

--Sig_/3+Mz=5FDrJN8Npkin0xb5y3--
