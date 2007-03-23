Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E49ADDDFF7
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 18:16:49 +1100 (EST)
Date: Fri, 23 Mar 2007 18:16:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] fix link errors when eeh is disabled
Message-Id: <20070323181657.d0a6e823.sfr@canb.auug.org.au>
In-Reply-To: <20070322221407.GA13592@aepfle.de>
References: <20070322221117.GA13481@aepfle.de>
	<20070322221407.GA13592@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__23_Mar_2007_18_16_57_+1100_O4f9Xfgf0=y.zC+A"
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__23_Mar_2007_18_16_57_+1100_O4f9Xfgf0=y.zC+A
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 22 Mar 2007 23:14:07 +0100 Olaf Hering <olaf@aepfle.de> wrote:
>
> fix link errors with CONFIG_EEH=n
>
> arch/powerpc/platforms/built-in.o: In function `.pcibios_fixup_new_pci_devices':
> (.text+0x41c8): undefined reference to `.eeh_add_device_tree_late'
> arch/powerpc/platforms/built-in.o: In function `.init_phb_dynamic':
> (.text+0x4280): undefined reference to `.eeh_add_device_tree_early'
> arch/powerpc/platforms/built-in.o: In function `.pcibios_remove_pci_devices':
> (.text+0x42fc): undefined reference to `.eeh_remove_bus_device'
> arch/powerpc/platforms/built-in.o: In function `.pcibios_add_pci_devices':
> (.text+0x43c0): undefined reference to `.eeh_add_device_tree_early'
> arch/powerpc/platforms/built-in.o: In function `.pSeries_final_fixup':
> (.init.text+0xb4): undefined reference to `.pci_addr_cache_build'
> arch/powerpc/platforms/built-in.o: In function `.pSeries_setup_arch':
> setup.c:(.init.text+0x620): undefined reference to `.eeh_init'
> make[1]: *** [.tmp_vmlinux1] Error 1

This was partly fixed by commit bed59275810a55500e885cbdc5c2a0507f13c00e
in Paulus' powerpc tree.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__23_Mar_2007_18_16_57_+1100_O4f9Xfgf0=y.zC+A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGA37uFdBgD/zoJvwRAmCAAKCXsZsYdS1c3d20Uw2R74gp6EWKNgCgjRwf
GGyAYxRnuLRv8DHEf388bEs=
=tw2n
-----END PGP SIGNATURE-----

--Signature=_Fri__23_Mar_2007_18_16_57_+1100_O4f9Xfgf0=y.zC+A--
