Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id 9CA97B7CDA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jan 2010 07:20:14 +1100 (EST)
Date: Fri, 22 Jan 2010 21:11:39 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: MPC5200B XLB Configuration Issues, FEC RFIFO Events, ATA Crashes
To: Roman Fietze <roman.fietze@telemotive.de>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <200912161237.09796.roman.fietze@telemotive.de> (from
	roman.fietze@telemotive.de on Wed Dec 16 12:37:09 2009)
Message-Id: <1264191106.2224.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-/NjbajBbvZ/vCcVUMuQy"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-/NjbajBbvZ/vCcVUMuQy
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Roman:

Am 16.12.09 12:37 schrieb(en) Roman Fietze:
> The board is using the MPC5200B on a board derived from the old lite5200,=
 but with the fixes for the MPC5200B. All tests are run using an ST940813AM=
 hard drive with an ext2 and an ext3 of 10GB each, default mkfs options. Th=
e OS is Debian 4.0. The =20
> network connection is between a fast Athlon XP2 6400 and the target, usin=
g 100MBit/s wiring and a 100MBit/s switch.

Are there any "final" conclusions from your tests?

I am using a board derived from the Lite5200b, running u-boot 2009.03 and a=
 recent stock kernel, where I performed tests concurrently reading and writ=
ing data to and from
- two compactflash cards with vfat file systems attached to the ata bus;
- a nfs3 network drive, connected via a 100MBit line, on a Xeon serve;
- a signal processor attached to the localbus, using bestcomm and the fifo =
for the bulk transfer.

I did not observe any issues, but your statements are making me really nerv=
ous...

Thanks,
Albrecht.

--=-/NjbajBbvZ/vCcVUMuQy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLWgaCn/9unNAn/9ERAj3pAKCQwVm6ecx8rVZNezfFXQ0/V646tQCgw0mW
3QIAUQs9vLAr7jUn+YeHq+Q=
=shH8
-----END PGP SIGNATURE-----

--=-/NjbajBbvZ/vCcVUMuQy--
