Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7FDCDB6F3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 17:48:20 +1100 (EST)
Date: Wed, 20 Jan 2010 17:48:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Avi Kivity <avi@qumranet.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: linux-next: kvm tree build warning
Message-Id: <20100120174814.43195995.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__20_Jan_2010_17_48_14_+1100_/UdAP83nse0eUvCL"
Cc: linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__20_Jan_2010_17_48_14_+1100_/UdAP83nse0eUvCL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Not sure what happened to the previous versions To/CC lists, sorry]

Hi all,

Today's linux-next build (powerpc allyesconfig) produced this warning:

arch/powerpc/kvm/book3s.c: In function '__kvmppc_vcpu_run':
arch/powerpc/kvm/book3s.c:1102: warning: 'ext_bkp.vrsave' may be used unini=
tialized in this function

Introduced by commit 2609c1d06b6a7952273fb33b33ad32aff0628146 ("KVM: PPC:
Add support for FPU/Altivec/VSX").  This *may* be a false positive but
will be a problem for normal builds where warnings are treated as errors
in arch/powerpc.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__20_Jan_2010_17_48_14_+1100_/UdAP83nse0eUvCL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktWpy4ACgkQjjKRsyhoI8zjWgCdGZ+91dcQ9xNwHclINlXj1yGJ
XZ8An0667fIZEh1KcWj4k/YlsLpLeoAa
=42oX
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Jan_2010_17_48_14_+1100_/UdAP83nse0eUvCL--
