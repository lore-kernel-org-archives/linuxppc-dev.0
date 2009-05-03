Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 96E06DDDFA
	for <linuxppc-dev@ozlabs.org>; Sun,  3 May 2009 20:45:50 +1000 (EST)
Date: Sun, 3 May 2009 20:45:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: unexpected non-allocatable section
Message-Id: <20090503204546.691ec6e7.sfr@canb.auug.org.au>
In-Reply-To: <20090502224126.641c63bf@lappy.seanm.ca>
References: <20090502224126.641c63bf@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__3_May_2009_20_45_46_+1000_t3U7mN/rLzlnI=gE"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__3_May_2009_20_45_46_+1000_t3U7mN/rLzlnI=gE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Sat, 2 May 2009 22:41:26 -0400 Sean MacLennan <smaclennan@pikatech.com> =
wrote:
>
> Latest pull from Linus' git.
>=20
> Cheers,
>    Sean
>=20
> WARNING: vmlinux.o (.text): unexpected non-allocatable section.
> Did you forget to use "ax"/"aw" in a .S file?
> Note that for example <linux/init.h> contains
> section definitions for use in .S files.
>=20
> WARNING: vmlinux.o (.head.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (.init.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (.ref.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (.cpuinit.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (.sched.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (.meminit.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (.exit.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (.devexit.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (.devinit.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (.rodata): unexpected non-allocatable section.
> WARNING: vmlinux.o (__param): unexpected non-allocatable section.
> WARNING: vmlinux.o (__ksymtab): unexpected non-allocatable section.
> WARNING: vmlinux.o (__ksymtab_strings): unexpected non-allocatable sectio=
n.
> WARNING: vmlinux.o (.rodata.str1.4): unexpected non-allocatable section.
> WARNING: vmlinux.o (__bug_table): unexpected non-allocatable section.
> WARNING: vmlinux.o (__ksymtab_gpl): unexpected non-allocatable section.
> WARNING: vmlinux.o (.init.ramfs): unexpected non-allocatable section.
> WARNING: vmlinux.o (__ex_table): unexpected non-allocatable section.
> WARNING: vmlinux.o (.kprobes.text): unexpected non-allocatable section.
> WARNING: vmlinux.o (__ftr_alt_97): unexpected non-allocatable section.
> WARNING: vmlinux.o (__ftr_fixup): unexpected non-allocatable section.
> WARNING: vmlinux.o (.rodata.cst4): unexpected non-allocatable section.
> WARNING: vmlinux.o (.fixup): unexpected non-allocatable section.
> WARNING: vmlinux.o (.data): unexpected non-allocatable section.
> WARNING: vmlinux.o (.init.setup): unexpected non-allocatable section.
> WARNING: vmlinux.o (.init.data): unexpected non-allocatable section.
> WARNING: vmlinux.o (.data.read_mostly): unexpected non-allocatable sectio=
n.
> WARNING: vmlinux.o (.initcallrootfs.init): unexpected non-allocatable sec=
tion.
> WARNING: vmlinux.o (.initcall3.init): unexpected non-allocatable section.
> WARNING: vmlinux.o (.data.page_aligned): unexpected non-allocatable secti=
on.
> WARNING: vmlinux.o (.data.init_task): unexpected non-allocatable section.
> WARNING: vmlinux.o (.initcall6.init): unexpected non-allocatable section.
> WARNING: vmlinux.o (.initcall4.init): unexpected non-allocatable section.
> WARNING: vmlinux.o (.cpuinit.data): unexpected non-allocatable section.
> WARNING: vmlinux.o (.initcall2.init): unexpected non-allocatable section.
> WARNING: vmlinux.o (.con_initcall.init): unexpected non-allocatable secti=
on.
> WARNING: vmlinux.o (.initcall7.init): unexpected non-allocatable section.
> WARNING: vmlinux.o (.machine.desc): unexpected non-allocatable section.
> WARNING: vmlinux.o (.data.cacheline_aligned): unexpected non-allocatable =
section.
> WARNING: vmlinux.o (.initcallearly.init): unexpected non-allocatable sect=
ion.
> WARNING: vmlinux.o (.initcall1.init): unexpected non-allocatable section.
> WARNING: vmlinux.o (.initcall5.init): unexpected non-allocatable section.
> WARNING: vmlinux.o (.ref.data): unexpected non-allocatable section.
> WARNING: vmlinux.o (.meminit.data): unexpected non-allocatable section.
> WARNING: vmlinux.o (.exitcall.exit): unexpected non-allocatable section.
> WARNING: vmlinux.o (.init.rodata): unexpected non-allocatable section.
> WARNING: vmlinux.o (.devinit.data): unexpected non-allocatable section.
> WARNING: vmlinux.o (.initcall0.init): unexpected non-allocatable section.
> WARNING: vmlinux.o (.initcall7s.init): unexpected non-allocatable section.
> WARNING: vmlinux.o (.sdata): unexpected non-allocatable section.

[Quoted in full for Sam's benefit]

What gcc, binutils versions and config ae you using?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__3_May_2009_20_45_46_+1000_t3U7mN/rLzlnI=gE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkn9ddoACgkQjjKRsyhoI8yJ4QCgrGbTL+CEuyeCt0OLFkoPDn5+
gBMAoLuXYto9XJ/isin3Du/SJtdGNIlF
=hmBw
-----END PGP SIGNATURE-----

--Signature=_Sun__3_May_2009_20_45_46_+1000_t3U7mN/rLzlnI=gE--
