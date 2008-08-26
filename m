Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id AD9EBDE7AC
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 16:18:49 +1000 (EST)
Date: Tue, 26 Aug 2008 08:18:41 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: MPC5200 FEC problems
Message-ID: <20080826061841.GA4253@pengutronix.de>
References: <48B2D167.40008@mlbassoc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
In-Reply-To: <48B2D167.40008@mlbassoc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gary,

On Mon, Aug 25, 2008 at 09:36:07AM -0600, Gary Thomas wrote:

> I'm adding the Analogue & Micro Boa (MPC5200/B) platform to the
> public 2.6.26 tree.  Under heavy network load (sometimes even
> not so heavy!), I get this error:
>   net eth0: FEC_IEVENT_RFIFO_ERROR

Yeah, I know this one :(

> My question is - what exactly does this error imply?  Looking at
> the MPC5200 manual doesn't give much info - just that there was
> a Rx FIFO error.

In deed, the manual seems not very helpful. The description of the set FIFO
status bit did not help me that much.

> I'm also perplexed by the fact that I have two slightly different
> Boa boards (same CPU rev, speed, etc).  About the only thing that's
> different is the SDRAM setup.  One board is rock solid while the
> other gets this error almost immediately.

I'm not sure if this is really of importance, but do the boards have
different PHYs?

> Note that I don't have any trouble with this platform running RedBoot
> or eCos, just Linux :-(
Try this patch and please report if it worked for you:

http://www.nabble.com/-PATCH--MPC52XX:-Don't-touch-pipelining-for-MPC5200B-=
td19028341.html

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIs6BBD27XaX1/VRsRAlQBAJ4xKlXy5IMJj4dDob9BcJZFyDyU5ACgvexH
UQ7Y3mWFg7AZ/IRU8M0re5g=
=LnWY
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
