Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8FC05DDDD6
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 14:29:18 +1100 (EST)
Date: Wed, 21 Nov 2007 14:29:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] sys_indirect kernel implementation for PowerPC
Message-Id: <20071121142913.38b8f437.sfr@canb.auug.org.au>
In-Reply-To: <18243.41278.72798.100000@cargo.ozlabs.ibm.com>
References: <18243.41278.72798.100000@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__21_Nov_2007_14_29_13_+1100_HHL1JB=h3vxIkvkj"
Cc: linuxppc-dev@ozlabs.org, Ulrich Drepper <drepper@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__21_Nov_2007_14_29_13_+1100_HHL1JB=h3vxIkvkj
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Nov 2007 14:08:46 +1100 Paul Mackerras <paulus@samba.org> wrote:
>
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -461,6 +461,25 @@ ppc_swapcontext:
>  	b	sys_swapcontext
> =20
>  /*
> + * long call_compat_syscall(struct indirect_registers32 *regs)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Presumably a copy and paste glitch.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Nov_2007_14_29_13_+1100_HHL1JB=h3vxIkvkj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHQ6YMTgG2atn1QN8RAn8oAJ9mqznK2BIVfMzpfcdEzgSrFpjRyQCfVg0x
Mf/JXJ98cUYJpq+wQ5v+/c8=
=lRp3
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Nov_2007_14_29_13_+1100_HHL1JB=h3vxIkvkj--
