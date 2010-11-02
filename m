Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] iSeries: Remove unused mf_getSrcHistory function.
From: Michael Ellerman <michael@ellerman.id.au>
To: Jesper Juhl <jj@chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1011012218420.12889@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1010301911220.1572@swampdragon.chaosbits.net>
	<1288609842.10671.7.camel@concordia>
	<20101102071025.2fe5e6ca.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1011012104050.12889@swampdragon.chaosbits.net>
	<20101102082634.65342ce6.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1011012218420.12889@swampdragon.chaosbits.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-eOCPNPdZIoaSyHjGARJV"
Date: Tue, 02 Nov 2010 11:20:50 +1100
Message-ID: <1288657250.16790.4.camel@concordia>
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


--=-eOCPNPdZIoaSyHjGARJV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-11-01 at 22:20 +0100, Jesper Juhl wrote:
> Hi Stephen,
>=20
> On Tue, 2 Nov 2010, Stephen Rothwell wrote:
>=20
> > On Mon, 1 Nov 2010 21:06:23 +0100 (CET) Jesper Juhl <jj@chaosbits.net> =
wrote:
> > >
> > > Remove unused function 'mf_getSrcHistory' (that will never be used ev=
er=20
> > > according to Stephen Rothwell).
> > >=20
> > > Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> >=20
> > Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >=20
>=20
> Ok, so if you are the (unofficial) iSeries maintainer and you don't merge=
=20
> the patch somewhere that'll eventually go up-stream, but just ACK it=20
> (thank you for that btw), then where do I send it to get it merged?

Here. ie. linuxppc-dev.

But, while you're removing it you should remove the #if 0'ed callsite as
well, see mf_src_proc_show() in that file. :)

cheers

--=-eOCPNPdZIoaSyHjGARJV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzPWV8ACgkQdSjSd0sB4dI0NwCfTXSXao1Giw2lp56QfPOY6Q9J
jR8AoJYnOXUTU4jBSlCFRJ9V6CMeIT5B
=732g
-----END PGP SIGNATURE-----

--=-eOCPNPdZIoaSyHjGARJV--
