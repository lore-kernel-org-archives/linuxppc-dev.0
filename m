Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F17E067A75
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2005 18:28:28 +1100 (EST)
Date: Thu, 10 Mar 2005 08:28:03 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
Message-ID: <20050310072803.GR4017@Redstar.dorchain.net>
References: <20050303124435.GA24233@Redstar.dorchain.net>
	<4227153C.3030201@gmx.net>
	<20050303141832.GU25080@Redstar.dorchain.net>
	<20050304075703.GA15637@Redstar.dorchain.net>
	<422FD24F.4070108@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CQDko/0aYvuiEzgn"
In-Reply-To: <422FD24F.4070108@jp.fujitsu.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: boot time scheduling hile atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--CQDko/0aYvuiEzgn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2005 at 01:51:27PM +0900, Takeharu KATO wrote:
> > I am more wondering what in proc_root_init or immediately after it
> > causes a call to the exit_work syscall.
> >=20
> This is not called by proc_root_init.
> It seems be called by timer interrupt
> (I confirmed it by viewing trap number in
> interrupt context with ICE).

I came to the same idea. This explains as well why the i386 party does
not notice the effect, as their first interrupt happen later (different
HZ value)

At this point, I was out of clue, so thank you for your help.

Bye,

Joerg

--CQDko/0aYvuiEzgn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCL/cDjY4+4PdzvOARArk6AJ9hU3fHw7gWLzZcjGkdSLQQCY+KDACff9HR
nIsweIjyinrfebjXaL+BRzg=
=EbBh
-----END PGP SIGNATURE-----

--CQDko/0aYvuiEzgn--
