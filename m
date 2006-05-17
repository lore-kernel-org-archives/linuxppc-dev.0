Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B811867A58
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 22:18:04 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h7j4m40kf.wl%tiwai@suse.de>
References: <1147780945.29795.110.camel@johannes>
	<s5h7j4m40kf.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-tzaq+7jw3g0GL/6/SoNi"
Date: Wed, 17 May 2006 14:17:54 +0200
Message-Id: <1147868274.15507.6.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-tzaq+7jw3g0GL/6/SoNi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-16 at 14:27 +0200, Takashi Iwai wrote:

> I don't think it's alsa-lib that prevents the negative or non-zero
> integer range.  The fact amixer works implies that it's an
> app-specific bug.  But I'm not 100% sure and need more
> inside-looking.=20

Basically, I think what I'm saying is: "why doesn't alsa-lib shift the
range to start at zero?"
It already does so many manipulations, that one wouldn't hurt...

johannes

--=-tzaq+7jw3g0GL/6/SoNi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsUcKVg1VMiehFYAQIrFw/+JHlsySCmNJ7WvXz/dl6S4IJrX8OkTezK
Wj+CUuTACk3xYMUCmDDsZtYj2ef3jpZHStIVUREPGwacRUDrKe6S9z1/YATT++7P
KTLh0BSmtAEw000HqOk92uxTHDKmfa8Cq+UwcI+Wj8go3d0k392wUI3wa01P6Qt7
MJ2vsEN1LiWeIJkY4pbCaJRWZYIwvhIC5OQf+w7namYixquULNO9tX8r7KL3I6PJ
9f0qNrm2Pt/gQC+kCZJlPUBgxV3VFpnaszN5scqNSPE+ic8wV4J0vMqzIERA2uZd
5aKsX2MSiRoP/hExeR0907hbZT6a2BtENRU1xvBfa6SlX6QqpvdrY1FpDJrdk4LP
UTUnshX6IxI0K9S8gvtuI5ktWKg/LhUmZG/nKOpIYGh0Er/RM0ELnmpSHjuw+/q0
Wl6K+zWg7DJzRM3JoX1c8WmvDzuF2f/MTSX4P69KrgYjIO8XvpOwbgiJcC7ffuTt
Tmr20kUcssl9N9hVVbummTlX0qizh4x9ZQGr2f61RvmDwpHZZYvGSTK0Fy3oRoUw
JMPBdSJJ2zOgP87It8d8zllfaJM2cYPrr2mxM8De4McYU9baH+RUzb2fpk1qgVxA
G/cwv4jXElgXd/OYPDftKKBus6XbLniCDI/ucu+AP/Siaki3uD2pGlPPG6gYkvml
h7jXjB0slC4=
=MgzH
-----END PGP SIGNATURE-----

--=-tzaq+7jw3g0GL/6/SoNi--
