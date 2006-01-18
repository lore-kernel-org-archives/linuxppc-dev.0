Return-Path: <laforge@netfilter.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09861689E0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 02:21:12 +1100 (EST)
Date: Wed, 18 Jan 2006 16:01:58 +0100
From: Harald Welte <laforge@netfilter.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Subject: Re: 2.6.16-rc1: iptables broken on ppc32?
Message-ID: <20060118150158.GL4603@sunbeam.de.gnumonks.org>
References: <17358.19458.555996.684819@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
In-Reply-To: <17358.19458.555996.684819@alkaid.it.uu.se>
Cc: linuxppc-dev@ozlabs.org, netfilter-devel@lists.netfilter.org,
	linux-kernel@vger.kernel.org
Reply-To: netfilter-devel@lists.netfilter.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2006 at 03:09:06PM +0100, Mikael Pettersson wrote:
> When trying out kernel 2.6.16-rc1 on a ppc32 box (G4 eMac),
> the kernel refused to load my /etc/sysconfig/iptables. strace
> on /sbin/iptables-restore shows that the kernel returns EINVAL
> instead of accepting the configuration:

thanks for letting us know, you might have catched a very important bug.

We've introduced a number of changes (x_tables) that haven't received
testing on all architectures yet.

I will try to reproduce the bug on my debian ppc box here.

This is not meant as a fix, but you might try it to narrow down the
problem:  Try recompiling iptables on your own, and report back whether
that works or not.

Please Follow-up-to netfilter-devel@lists.netfilter.org

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDzlhmXaXGVTD0i/8RAuxWAKCJEYDaJKIY62DJFMie5Xjc1MWGSQCcD87x
XWvW1z5qr4aJQ31RxIdj4Zg=
=f1wE
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
