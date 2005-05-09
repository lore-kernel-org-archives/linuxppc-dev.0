Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 62514679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 06:05:02 +1000 (EST)
In-Reply-To: <427F3441.2010108@web.de>
Content-Type: multipart/signed; boundary="=-AFAPEJkROvEFWUG5vgSJ";
	micalg=pgp-sha1; protocol="application/pgp-signature"
References: <427F3441.2010108@web.de>
Date: Mon, 09 May 2005 16:04:57 -0400
Message-ID: <1115669098.9050.48.camel@jmcmullan.timesys>
MIME-Version: 1.0
Date: Mon, 9 May 2005 15:59:17 -0400
Message-ID: <1115669098.9050.48.camel@jmcmullan.timesys>
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: "Peter Asemann" <peter.asemann@web.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: Writing a small test program - a bit off topic
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-AFAPEJkROvEFWUG5vgSJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-05-09 at 11:58 +0200, Peter Asemann wrote:
> I *hope* this mail isn't very off topic. In principle it probably is,=20
> but I don't know a mailing list which is about writing test programs to=20
> test processors in order to debug a hardware to get linux running. Plus,=20
> I suppose there are people out there who could help me. So I hope you=20
> won't stone me for this post.

assuming 'foo.c' is your program, and you want to run it at origin 0.

Step 1)	ppc8xx-linux-gcc -Dmain=3D_start -nostdlib foo.c -o foo

Step 2) ppc8xx-linux-objcopy foo -O binary foo.bin

Done!

=09
--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-AFAPEJkROvEFWUG5vgSJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCf8Jp8/0vJ5szK6kRAvp8AKCB4sLS3Vs9/XOJXD4wHnWQVT2KTwCdHxfn
QtvuB/S93NssTUCTU2nFxSg=
=ISen
-----END PGP SIGNATURE-----

--=-AFAPEJkROvEFWUG5vgSJ--
