Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4C401A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 12:09:24 +1100 (AEDT)
Date: Thu, 13 Nov 2014 01:34:19 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Message-ID: <20141113003418.GE2062@katana>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net>
 <5450AC85.40302@keymile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
In-Reply-To: <5450AC85.40302@keymile.com>
Cc: Linux device trees <devicetree@vger.kernel.org>, "Boschung,
 Rainer" <Rainer.Boschung@keymile.com>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> If we wanted to be on the safe side and strict (since we are not sure that the
> hardware is 100% compatible), we maybe should add a fsl,qoriq-i2c compatible to
> the driver that does the same as mpc8543-i2c.

Or you leave the driver as is and use both compatibles:

compatible = "fsl,qoriq-i2c", "fsl,mpc8543-i2c", "fsl-i2c";

?

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY/yKAAoJEBQN5MwUoCm2m98P/ix5SsOvuRsDYFbeDB3XqNyN
16yH9cU7oGeDHPFyvqzcnZ++d6+r0tpaErXOU3GS2NBdaMnNMHogmhBIbmCbdlW8
A3gp2+mY/BnSmvl6dv5tqKzjqX2zZ5+3KOj6EcVAXVR9bz5qmFpKrEsZYv++BQj/
tNEAUN7iy2gt33kckfBxpfrIwjAiylsKae3hqLMhmry8x5rd2/KrkGB6qL1QOaAx
wV4ZIMcDBDVO7u4lmokl9heRebED6vYB8YiTWZH1dDz1whbN2loUGZroTmR+dbAv
2UY+S2CMxUg1bQPkyDVe2GglZ1wXit8SKToa/mClSeXtpiW546JzcYW0Ep4HUQf3
lv9+Lg1ne+y771u/Pome2MUPHR6Ntuuy9GHxQad/kx/1jRe6/C3yko+3VoQj9SrY
3sNXLcUmraRLQL/3EjOJdjFOJapjkopt5Jh4Lt6jIueOjEZLBXEbVJgGiHyS1IU7
61FeVvl6Mxt8lt2zsUjT8IBzi8xh43zquzHjJgjAXH4CxHXx7y+GURJmclXmOf0h
HE5qMLRerHOC7Fr4pOnuXixehhrxKZsz9MuUk2NMnAlqEULxgRMCXbzw9rRLKVSS
m2VsqDdYRABZjLrhIFmfWOMnye4tKMd/I7qitE617QhZFqc9+YsiJoFHj3Tncchc
zA+pXncSKBWHcPRjo/DJ
=XA65
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
