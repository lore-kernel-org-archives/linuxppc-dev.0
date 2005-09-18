Return-Path: <Simon.Richter@hogyros.de>
Received: from psionic8.psi5.com (psionic.psi5.com [212.112.229.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.psi5.com", Issuer "psi5.com CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9566E682DD
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Sep 2005 20:55:45 +1000 (EST)
Message-ID: <432D4109.3040807@hogyros.de>
Date: Sun, 18 Sep 2005 12:27:21 +0200
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
References: <15A1D026-00E3-4652-ABA5-9A8B8517A2CA@freescale.com>
	<432C7324.9070203@linux-m68k.org>
In-Reply-To: <432C7324.9070203@linux-m68k.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3886AED7C9B50D67FC651F99"
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Reminder: removal of APUS and Gemini still pending
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3886AED7C9B50D67FC651F99
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Roman Zippel schrieb:

> Regarding APUS: with the current rate of changes I simply don't have the
> time to catch up right now. What's the game plan here? If I miss the
> deadline, I have to start from scratch?

Well, I have a tree that sort of works, but needs to be merged with the
ongoing changes, and possibly the patch should be split as well. Do you
have an archive of patches submitted to you, so they can be applied
separately?

(On a related note, are you going to be at the Oldenburg meeting this
year? I'm planning to catch up on APUS there and have some commit
objects ready at the end of it.)

   Simon

--------------enig3886AED7C9B50D67FC651F99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQCVAwUBQy1BGVYr4CN7gCINAQLtpQP8CjkbN3K9xfQp4mpjfyeGJokPOtJm4hna
lGZTzhhk74O2ut5c727Fw4wg//zP/FMaAe2gMsUv+izgE2PnCkX8PuXEjRb33i6/
dpeBkNiPA5gDMN7B12f84lKu8t7cWYeclh4rgS/cBxJK423dQXveCoAtmsQdK62v
dzR10g5ekH0=
=tO/r
-----END PGP SIGNATURE-----

--------------enig3886AED7C9B50D67FC651F99--
