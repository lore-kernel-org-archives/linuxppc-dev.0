Return-Path: <kiszka@rts.uni-hannover.de>
Received: from listserv.uni-hannover.de (listserv.uni-hannover.de
	[130.75.2.32]) by ozlabs.org (Postfix) with ESMTP id 34A7C68962
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 02:28:16 +1100 (EST)
Message-ID: <43B3FCD4.2020409@rts.uni-hannover.de>
Date: Thu, 29 Dec 2005 16:12:20 +0100
From: Jan Kiszka <kiszka@rts.uni-hannover.de>
MIME-Version: 1.0
To: The Linux Socket CAN Framework <socket-can@pengutronix.de>
References: <200512271730.28563.david.jander@protonic.nl>	<20051227214949.GA8236@mail.gnudd.com>	<200512281000.12073.david.jander@protonic.nl>	<43B2A902.3090008@varma-el.com>
	<20051229134355.GH19375@pengutronix.de>
In-Reply-To: <20051229134355.GH19375@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2B3E464D0BC71E894057116C"
Cc: David Jander <david.jander@protonic.nl>, urs.thuermann@volkswagen.de,
	oliver.hartkopp@volkswagen.de, linuxppc-embedded@ozlabs.org
Subject: Re: [Socket-can] Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B3E464D0BC71E894057116C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Robert Schwebel wrote:
> ...
> In december, we have made a synchronisation meeting with the VW people
> who made the initial port for 2.4; they are more focussed on having
> higher level transport protocols ontop of the "raw" socket interface we
> currently use. During that process we have reviewed the user interface
> with regard to their use cases, so it will have to be changed a little
> bit before we have something which is in a state to be posted on lkml.
> 

Beyond the outstanding comparably minor API adjustments, we furthermore
discussed first ideas how to define the lowest interface, i.e. the CAN
network device layer. That should be done in a way which makes porting
CAN low-level drivers between the standard kernel and a real-time Linux
CAN stack trivial. That's a unique chance (compared to the situation of
RTnet e.g.), so we should take it.

This real-time stack is to be derived from the RT-SJA1000 driver
Wolfgang pointed at. It is already based on an abstraction layer (RTDM)
that makes it portable across many of the various RT-Linux variant. So
far this includes support for Xenomai and RTAI, RTLinux/GPL is planning
to adopt RTDM as well. This means we could end up with portable CAN
applications and drivers, RT and non-RT!

As Robert said, it "just" requires some resources for implementing
this... ;)

Jan

--------------enig2B3E464D0BC71E894057116C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDs/zUncNeS9Q0k+IRAnsSAJoDOAXT/ztDqMgYJo/rtBodqZbgYQCfZnAm
nQMxzz9JLaa/U23osH2bfgE=
=3Pof
-----END PGP SIGNATURE-----

--------------enig2B3E464D0BC71E894057116C--
