Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] iSeries: Remove unused mf_getSrcHistory function
	and caller.
From: Michael Ellerman <michael@ellerman.id.au>
To: Jesper Juhl <jj@chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1011182044490.3651@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1010301911220.1572@swampdragon.chaosbits.net>
	<1288609842.10671.7.camel@concordia>
	<20101102071025.2fe5e6ca.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1011012104050.12889@swampdragon.chaosbits.net>
	<20101102082634.65342ce6.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1011012218420.12889@swampdragon.chaosbits.net>
	<1288657250.16790.4.camel@concordia>
	<alpine.LNX.2.00.1011050026220.16015@swampdragon.chaosbits.net>
	<alpine.LNX.2.00.1011182044490.3651@swampdragon.chaosbits.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-4BJN8Wjt2wBvi4xzZk3M"
Date: Fri, 19 Nov 2010 08:57:50 +1100
Message-ID: <1290117470.29105.9.camel@concordia>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-4BJN8Wjt2wBvi4xzZk3M
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-11-18 at 20:45 +0100, Jesper Juhl wrote:
> On Fri, 5 Nov 2010, Jesper Juhl wrote:
> > =20
> >  static int mf_src_proc_open(struct inode *inode, struct file *file)

> PING.
>=20
> Is this going to get merged somewhere or is there a problem?

Yes, no.

It won't get lost:
http://patchwork.ozlabs.org/patch/70201/

cheers


--=-4BJN8Wjt2wBvi4xzZk3M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzloV4ACgkQdSjSd0sB4dJHIgCgyXtCb2bwWcKLFacEvA7LNsyp
aPoAn3Z2Z773EE8BQ3m1P3bi7dY/o6fi
=yvXG
-----END PGP SIGNATURE-----

--=-4BJN8Wjt2wBvi4xzZk3M--
