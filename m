Return-Path: <nico-linux-ppc@schottelius.org>
Received: from scice.schottelius.org (ns.schottelius.org [213.146.113.242])
	by ozlabs.org (Postfix) with SMTP id C3DFA67AB3
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2005 22:41:28 +1100 (EST)
Date: Wed, 26 Jan 2005 12:35:54 +0100
From: Nico Schottelius <nico-linux-ppc@schottelius.org>
To: Joerg Dorchain <joerg@dorchain.net>
Message-ID: <20050126113554.GD19633@schottelius.org>
References: <20050118094216.GB25470@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
In-Reply-To: <20050118094216.GB25470@Redstar.dorchain.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!


Joerg Dorchain [Tue, Jan 18, 2005 at 10:42:16AM +0100]:
> [heartbeat blink patch]

Well, wouldn't it make much more sense to write a
/dev/frontled to access it via userspace?=20

Then one could enable much more features like
- xmms plugins
- num-lock led
- network-traffic
- morse-codes
- glowing when typing
- ...

Nico

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQfeAmLOTBMvCUbrlAQIL9Q/9HvOU9j27e6s2CbhBkbsIVZmbgb0XXeCt
68sZR2HJx6iFY/NjGiQWh5jm6mYGDAfvyzHbd8ss4OL0dBP7NJddqgvFcQ9sj1Ev
6okCaC/tjJSYLqi6YdpAkrd3m8g+ibfZpD77SGJckc6JmIrJFCB/9zGFlwCGLaqK
saZY+1fBKt8afpld3cEDHy2EQ/QoWV2I16eW6itl81LCGophppkxwYtW5CsFtgqU
ttMVPN8NsX0YTr6/MhooBo8fWdu4HzRTA2ynQT7iwBPihmN4oPF87ZAd+YiRGWq4
ASU7R+1yLbVxXV08oENxOinRJ822y2MztyEdAo8HOog5r8S/4QvT34CyGxH0XKBT
XtPbCWjG8Ew4XYkakkVcJdFfR8NnRTiJeBvlIBLduzUbIT+VJE7KyMU6hNF96z44
94qXbjz98fw+B6ZgkahKbIpCpImBXTwo8wKqKv8Ih0EOYTnpgJmJ/vmX20y0lMaA
hzzrDIBxaD4qT15ONm1Izg2fjc96twcj10FIQI8Gc8ZQ/94oa4U5HHir55apBLKD
6xEdtIRYhVXOicH99EVhuYtEjzNeg1Duy8Xp3256fxeALkrq8/vNu+ebGaJW/kEA
1FFkzIRjKNydUHM7JUpY3GRiWFnSlFcZqotKlBriEQBXVL92KHWfAHwHTRlI7FuE
aXO2Ipixj1k=
=uMod
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
