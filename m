Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DADEAB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 02:37:00 +1100 (EST)
Date: Tue, 2 Nov 2010 02:36:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: All Applied micro boards are failing with current mainline kernel
Message-Id: <20101102023650.bc553e74.sfr@canb.auug.org.au>
In-Reply-To: <AANLkTikQuUcAMZKqZ3Rz5HVzOs+63-Y4VYUo5-3EM30H@mail.gmail.com>
References: <6631e123845856ac20423c25e07844c8@mail.gmail.com>
	<AANLkTikWWGpAM8+_z9fnngYuYSpT3NWgM7xeGkOzZ3jg@mail.gmail.com>
	<AANLkTikQuUcAMZKqZ3Rz5HVzOs+63-Y4VYUo5-3EM30H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__2_Nov_2010_02_36_50_+1100_cUqEyzYYxkUuuGjl"
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Rupjyoti Sarmah <rsarmah@apm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"David S. Miller" <davem@davemloft.net>, Tom Herbert <therbert@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__2_Nov_2010_02_36_50_+1100_cUqEyzYYxkUuuGjl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Mon, 1 Nov 2010 11:05:53 -0400 Josh Boyer <jwboyer@gmail.com> wrote:
>
> A few hints would be appreciated.

Remove the call to netif_stop_queue() from emac_probe().  Apparently,
calling this before register_netdev() is now wrong (maybe always was).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__2_Nov_2010_02_36_50_+1100_cUqEyzYYxkUuuGjl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMzt6SAAoJEDMEi1NhKgbsj2EIAI8Yt9zCze2B0cT+qNFd+nci
YME4qQPBWLAeUVCe+KQMOBEbJjgKyUXgf42h44AAHepm2IwP6U+6tVdMsi3L6S5B
Ak4w2o6J+tM4iuy48pI0nyVEFrOUO3ZwFl0hYXz94zoNaKaxU2nzPRwYnGpYBhIb
2a3v7S9QV/4rbBX4/8WA3rZ8R4l/ZE8KaR/pa1cYh4WUfONDO3xT0pPSj5BrZDT1
cx4sKgdNtr6fpkm9sclBbuCT3BOW2ilv6i2+r7yo/2DRJVrXbGDu7AGHBokvvHhx
NiyYvlSKRqPSTTFQWDfvGDVv8OyaBWgBF8kSPB18P980dUKS+G9l+RWtvz0QeK4=
=lYu3
-----END PGP SIGNATURE-----

--Signature=_Tue__2_Nov_2010_02_36_50_+1100_cUqEyzYYxkUuuGjl--
