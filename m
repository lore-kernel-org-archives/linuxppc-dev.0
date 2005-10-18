Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dorchain.net", Issuer "Dorchain Family" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DAE65685D6
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Oct 2005 18:56:03 +1000 (EST)
Date: Tue, 18 Oct 2005 10:49:35 +0200
From: Joerg Dorchain <joerg@dorchain.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051018084935.GE28756@Redstar.dorchain.net>
References: <20051014123823.GA9477@Redstar.dorchain.net>
	<1129327105.21765.39.camel@gaston>
	<20051016081759.GA2609@Redstar.dorchain.net>
	<1129452167.7620.34.camel@gaston>
	<20051017183443.GB28756@Redstar.dorchain.net>
	<1129585466.7620.90.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
In-Reply-To: <1129585466.7620.90.camel@gaston>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.13 ati (ibook) frambuffer problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2005 at 07:44:26AM +1000, Benjamin Herrenschmidt wrote:
> > The 2.6.12 version worked. Would it make sense to post the complete
> > .config?

I got 2.6.13.4 booting. The last change I did was deselecting
CONFIG_FB_TILEBLITTING. Unfortunately, I have no idea how this actually
affects the ATI frambebuffer.=20

To make it even more strange, after reenabling CONFIG_FB_TILEBLITTING,
it still boots up cleanly. Obviously, I missed out on something.

Besides, I have the impression that the disk reacts slower. As hdparm
does not tell a difference, it might be due the coffein, tough.

>=20
> Nope. What may help is a bit more debugging. For example, does the
> kernel actually boots if you add "video=3Dofonly" to the kernel command
> line.

No effect.


Well, the good point is, it works again. The bad point, I do not know
why. Anyway, thanks for the support.

Bye,

Joerg

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDVLcfjY4+4PdzvOARAkjZAJ47CvJ/8pp7KkBr/9HUgN53UJTynACfRfqO
+TcuvpGzwHXvfbvkx84bgI8=
=c5bK
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
