Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 462D2DE2D4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 21:45:48 +1000 (EST)
Date: Fri, 15 Aug 2008 13:45:39 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [BUG] fec_mpc52xx: Don't call mpc52xx_fec_reset() in ISR
Message-ID: <20080815114539.GA25105@pengutronix.de>
References: <20080710123909.GA4275@pengutronix.de>
	<20080710153101.GD446@secretlab.ca>
	<200808131548.11813.jbe@pengutronix.de>
	<48A2EBC1.6020708@grandegger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <48A2EBC1.6020708@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wolfgang (and all),

On Wed, Aug 13, 2008 at 04:12:17PM +0200, Wolfgang Grandegger wrote:

> ...but I prepared a patch to do the reset in the process context. Would be
> nice if you could give the patch below a try.
Will do later. Thanks!

Still, I think it might be useful to discuss if a complete reset
is not overkill anyhow. The documentation says that only the FIFO
and the Bestcom needs to be reset. Or, if we take the "big hammer"
solution, it would be good to audit if this won't cause any
side-effects (do all related states get updated...).

Remember that there lately have been patches removing some improper
usage of netif_* calls; furthermore, I also found some questionable
areas in this code (mails will be sent later). So, this driver
needs some careful attention IMHO.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIpWxjD27XaX1/VRsRAlJnAKC6KqsbBTBv2NDfRDPTM/lLRdK9GwCfYe6Y
6xH6B3Rjqy2S1VwUimirlcQ=
=8Mrc
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
