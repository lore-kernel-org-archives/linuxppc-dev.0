Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D4BFBDDECF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 04:42:09 +1000 (EST)
Date: Tue, 10 Apr 2007 20:41:58 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: my powerbook fails to resume if backlight control is disabled
Message-ID: <20070410184158.GB22734@hansmi.ch>
References: <1175700040.3600.14.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
In-Reply-To: <1175700040.3600.14.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Johannes

On Wed, Apr 04, 2007 at 05:20:40PM +0200, Johannes Berg wrote:
> The thing is that I had turned off some options to the point where I
> had /sys/class/backlight but nothing in it. I don't know for sure what
> exactly these options were, but I do know that CONFIG_PMAC_BACKLIGHT and
> CONFIG_PMAC_BACKLIGHT_LEGACY were off, though that alone shouldn't
> cause /sys/class/backlight/radeonbl0 to disappear.

I tried a configuration like that and can't reproduce it. Maybe it's
because of some other driver.

Greets,
Michael

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGG9p26J0saEpRu+oRAv2CAKCOV5iEI/IBL7xDBlEFY93wtzYIOACfUYXI
tpQqjbM2WpCqcOMuBSt1AxY=
=18hD
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
