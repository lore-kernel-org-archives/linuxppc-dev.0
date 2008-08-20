Return-Path: <marc.leeman@gmail.com>
Received: from kim.schedom-europe.net (kim.schedom-europe.net [193.109.184.78])
	by ozlabs.org (Postfix) with SMTP id D9C23DDF89
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 17:02:36 +1000 (EST)
Date: Wed, 20 Aug 2008 06:55:54 +0000
From: Marc Leeman <marc.leeman@gmail.com>
To: Jayasri Sangu <JayasriS@aaesys.com>
Subject: Re: [gmail] DMA Cache problem on PPC8248.
Message-ID: <20080820065553.GP7472@crichton.homelinux.org>
References: <2DE723F44CAFD24A9B6BF606813F010C0945BE21@aae-exch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ga5bsqHr1s/xcZEm"
In-Reply-To: <2DE723F44CAFD24A9B6BF606813F010C0945BE21@aae-exch>
Cc: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--ga5bsqHr1s/xcZEm
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>    We are using PPC8248 provided by freescale and the kernel  2.6.10. I b=
elieve we have cache problem.
>   We are allocating DMA buffers in our driver. If we increase the DMA buf=
fer size the board hangs/halts(when try to load more applications).
>   If we reduce the DMA buffer size, then we can run all our applications.
>    Is there any way I can get around this problem.

Have a look at the u-boot code for the 8245; I once submitted a patch
for such a problem on an XPC8245 (experimental MPC8245). It's still in
the code; but disabled right now.

It might be the same silicon bug.

--=20
  greetz, marc
Yeah, yeah, yeah nothing like a bomb to sober me up, I'm fine.
	Crichton - Suns and Lovers
crichton 2.6.26 #1 PREEMPT Tue Jul 29 21:17:59 CDT 2008 armv5tel GNU/Linux

--ga5bsqHr1s/xcZEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIq7/4UQpj09NWLeERAonyAKCcEYCreI2/vx0CaQiYuNHWNRmZngCcC+5k
gB8tsI219EynXEnUchcYUAw=
=Thbf
-----END PGP SIGNATURE-----

--ga5bsqHr1s/xcZEm--
