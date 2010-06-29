Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 29 Jun 2010 12:38:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: Using devices trees on X86
Message-Id: <20100629123843.5f94d477.sfr@canb.auug.org.au>
In-Reply-To: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__29_Jun_2010_12_38_43_+1000_6/+G0i=trb5PHtPo"
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__29_Jun_2010_12_38_43_+1000_6/+G0i=trb5PHtPo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Mon, 28 Jun 2010 10:57:33 -0700 Stephen Neuendorffer <stephen.neuendorff=
er@xilinx.com> wrote:
>
> 2) config OF is currently implemented in the architecture code.  This
> should be non-architecture dependent and selected by the arches that
> need it.
>=20
> Comments greatly appreciated, in particular if you have
> likely-to-be-easy-to-get-accepted suggestions for 3), or feel like
> carefully solving 2) in
> a way which doesn't bork the existing of-based arches.

See the following patch set.  Parts 1, 2 and 3 could be applied to the
respective architecture trees as well as Grant's tree to aleviate some
conflict problems.  Part 5 could wait until a later time if necessary.
However, this is relatively trivial, so we could just collect ACKs and
put it all in Grant's tree and live with any minor pain.

Having OF in more than one Kconfig file should not cause any problems as
long as they are all the same.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__29_Jun_2010_12_38_43_+1000_6/+G0i=trb5PHtPo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMKVyzAAoJEDMEi1NhKgbsQRgIAIPkdifxF0VxMUohwgnhP1/R
tI24htug80Ew6UTIS2p3U2kVfKITfiqhBcROCsC5M7QDhlT4Yq4y5N622Hzth92W
Yfi9sqN+mHWXVni4dj3uZrUGaGiz9+ZUxO0Ltw8W7SWL9c5wMz6s5FW9BNV7mkHj
/1vVuUsAGoOdlTGpj/78ZZFbaAz0kELXHAy5n1aJsndxXra3GK1AktZhb7d5Pqf5
cjzgFfsh8QQ9J+ibWtNwXuLm5B+m8E6LqXP5j2yk5tU9R0OgOchtZrkNTRby6Usu
eH5k0CMgT6D77SAcSh4NnnaRxDSoSxj8wwFd/3ejwvH+VRUM9nintSNZNs2A604=
=jbyG
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2010_12_38_43_+1000_6/+G0i=trb5PHtPo--
