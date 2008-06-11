Return-Path: <mkl@pengutronix.de>
Message-ID: <484FD30B.3020105@pengutronix.de>
Date: Wed, 11 Jun 2008 15:28:43 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
References: <9e4733910806100738rac8e415x99f6e96715ebee90@mail.gmail.com>
	<20080610165719.GA5139@loki.buserror.net>
In-Reply-To: <20080610165719.GA5139@loki.buserror.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig415091A65DFD5283FA788FD2"
Subject: Re: Image generation for Efika is broken in 2.6.26
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig415091A65DFD5283FA788FD2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Scott Wood wrote:
> On Tue, Jun 10, 2008 at 10:38:31AM -0400, Jon Smirl wrote:
>> Why is my vmlinux.strip 3.2GB? Could a missing address be interpreted
>> as -1 (0xFFF..) and cause the image to contain all of memory?
>>
>> -rw-r--r--  1 jonsmirl jonsmirl   61738015 2008-06-10 10:31 vmlinux.o
>> -rwxr-xr-x  1 jonsmirl jonsmirl 3224175192 2008-06-10 10:31 vmlinux.st=
rip.3651
>>
>> After it is packed vmlinux is 32MB. Packing gigabytes of zeros, maybe?=

>>
>> -rwxr-xr-x  1 jonsmirl jonsmirl 32430673 2008-06-10 10:31 vmlinux
>>
>> This image won't load onto the Efika probably because it is trying to
>> expand back to 3.2GB.
>>
>> With the same .config vmlinux is 4.1MB on 2.6.25
>>
>> -rwxr-xr-x  1 jonsmirl jonsmirl 4119174 2008-06-09 20:09 vmlinux
>=20
> Are you using binutils 2.17?  It has a bug that was triggered by the p_=
paddr
> change.  Do you get a bunch of warnings from the strip command?

Same problem here with binutils-2.17. But no warnings from strip. Can
you give me some pointers to the original bug report or the fix of the
problem in the binutils svn. I've searched this mailinglist and the
binutils bugzilla, but without success.

cheers, Marc

--=20
 Marc Kleine-Budde              Phone: +49-231-2826-924
 Pengutronix - Linux Solutions for Science and Industry
 Vertretung West/Dortmund     http://www.pengutronix.de


--------------enig415091A65DFD5283FA788FD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIT9MLjTAFq1RaXHMRAjf3AJ9M0qghg35Djqc0EmHg3Wl3nb1QUgCgh212
hw3c632K6pOkUNHjIVWZeSQ=
=qb/o
-----END PGP SIGNATURE-----

--------------enig415091A65DFD5283FA788FD2--
