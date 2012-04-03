Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 3 Apr 2012 11:31:23 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] powerpc/boot: Only build board support files when
 required.
Message-ID: <20120403013122.GB9194@thor.bakeyournoodle.com>
References: <20120403005558.GA9194@thor.bakeyournoodle.com>
 <20120403010002.GE7481@truffala.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
In-Reply-To: <20120403010002.GE7481@truffala.fritz.box>
Cc: Frank =?utf-8?Q?Svendsb=C3=B8e?= <frank.svendsboe@gmail.com>,
 Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 11:00:02AM +1000, David Gibson wrote:
=20
> Um.. I believe the one platform breaking another is actually working
> as intended.  I think Paulus did it this way to stop people breaking
> platforms other than the one they were working on without realising
> it.

Well that may have been the original intent but in the thread "Re:
kilauea compilation breaks with v3.3 kernel and ELDK 4.2" we're seeing
4xx break 8xx as the 8xx binutils (in use) doesn't have a mfdcrx
instruction.

So by breaking it up we gain a small decrease in compile times, less
chance of a very targeted build breaking an unrelated board.  We do as
you point out potentially delay discovery of breakage for some time.

I don't mind either way but the patch is out there now :)

Yours Tony

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPelLqAAoJEEsCiJRY75GK3UgP/jT89ejceTksywe6gVoHb0Uq
WeyIxPcX42z8v2/U0hOsD3fVA7m9isHFGDvSpIYKrZLzrO7Q9/YKD5dbl4ok+uEz
kcgK9C6rb2o9sOyvBtNyoIF/nGfPzZcnYAgPgcD9FeTFuyLlncKp2IzjZ2FNSyCF
bITMUZd7HjIWfK2DkUs7gEeTtfHx9g9a/mAVOMHanIITt/oj5O1owq1XBU1x47P5
uSlQnwhZD9OXTvkULd579LPqlIDgfO3MXny5mRF/SmSk0CORGT/f2r/G5o2JytmU
BoXBX1yD/S3rLkqW2XyA0S8jL6gHEqb7qJt4s3rl5NvOGE+e0k3k7AZW4vcbi8o5
nmSKn8P0zl4LT/woRDQclzQda2tRDOsDRprtz0RE9BpeJabmBuG3PFwC5HxgGve5
bXpINhi3wKUF3n1xByrOFeKRIKZCmvzWM/iSIT2RrMuVxLrj3KZP9N+2VizxCWN7
EpYonh0hJu8k6A2EHKjmzZtYkAgtflhvn/VVipOwZQer26qFc0jViEH50j8DWvRJ
1VnywYItzfqbV4ceHvng3w+nkJV26vKhlIIZyLK3TmelDDPiWPgE6DVaEPj0J/HE
m9+0zp2PZsFh6alvSRaUUJe777uKkKrqKFBbkjrpX22/rY6OdqauW/JunK31LY3d
itvNKqFEGe80QKvw0N3x
=8cOm
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
