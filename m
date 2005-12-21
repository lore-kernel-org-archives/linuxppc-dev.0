Return-Path: <Simon.Richter@hogyros.de>
Received: from kleinhenz.com (kleinhenz.com [213.239.205.196])
	by ozlabs.org (Postfix) with ESMTP id 16969688E3
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2005 23:18:49 +1100 (EST)
Message-ID: <43A94811.4010704@hogyros.de>
Date: Wed, 21 Dec 2005 13:18:25 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Alessandro Zummo <azummo-lists@towertech.it>
References: <20051220220022.4e9ff931@inspiron>
In-Reply-To: <20051220220022.4e9ff931@inspiron>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3156E05571BFFD516F465568"
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	lm-sensors@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk,
	nslu2-developers@yahoogroups.com
Subject: Re: [RFC] RTC subsystem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3156E05571BFFD516F465568
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Alessandro Zummo wrote:

>   I've posted a proposal for a new RTC subsystem
>  on lkml ( http://lkml.org/lkml/2005/12/20/220 ) .

I agree that there is room for improvement. Do you have a specific 
structure in mind? Specifically,

  - which functions do you believe to be generic,
  - how should multiple RTCs be handled,
  - are read-only (radio controlled) RTCs taken care of?

At present, I don't have time to help the cause, but I can provide 
hosting for a git tree if desired.

    Simon

--------------enig3156E05571BFFD516F465568
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCUAwUBQ6lIHFYr4CN7gCINAQJBugP2LfaLZ8UmalAWaajBzRQyb6nVwhzXyJyx
I7ozrUQTLNfO2MC42LFF2nRKf5B+91wvc+BGUsgGIFQKqcGeC5jyzGM8m0EdUzI7
KtVryJCMTOmBDYPJRiDJ5vDJ9Q4Ubx9Gp+0jelp7tBJoi3Y4sKGkw0oGAkxa+CJV
Cve3Lj9KDw==
=xwcd
-----END PGP SIGNATURE-----

--------------enig3156E05571BFFD516F465568--
