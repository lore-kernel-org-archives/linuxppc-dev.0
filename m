Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 1 Dec 2011 12:11:49 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/6] 44x/pci: Continue pci setup even if there is no
 sdr-base in the device-tree
Message-ID: <20111201011149.GE15560@thor.bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-2-git-send-email-tony@bakeyournoodle.com>
 <1322631973.21641.42.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
In-Reply-To: <1322631973.21641.42.camel@pasglop>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2011 at 04:46:13PM +1100, Benjamin Herrenschmidt wrote:

> If you don't expect an sdr-base as part of the normal operations of that
> bridge, don't bring a message that makes me think something is wrong :-)
>=20
> Just changing the severity isn't enough. you should just remove the
> message and later on, print/warn/error out if you decide you actually
> need an sdr-base (such as in the backend).

Okay no problem.

Yours Tony

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO1tRVAAoJEEsCiJRY75GKRpYQALlJS4hxXvsG5rMm9WtJ69VJ
oo3b6RiaWLf2weD/3W1wqrQGHdRtsl/ZeqpPGE6wfGvF/X+S1iQgzsnlV3BA0pwh
VR6cUm68l47ipqosZjrivUxr3avGq8jJsfRhl6UuzMis1QTTo3IGKCuyrkuMrrcb
3L6lPVMP1jwYM2DE7xKjPzEZyZIn3qMaFXlvJU+auIh2i1OmNed34bT938J5b+UB
im9++Px3xSOlsKGXBbooriBztoNl1Sh493vMbObBQzxHIv0T2TBcNd1S9aV+GjQq
Xyhm1FjY6+xRS7CDqScYJ2D09GGDuqQ4tveZoQ6sueFC2d748F9p1OurY/AfV+fq
UWz4905Ia13YQQyhS3m9lL18yNZ5XTGUqLL9IiarkUwwywkpB/rlj+biP78U+Yyj
w/2ipvzkAiP6GgsBpOjWWbVDcpEYnHzmQWczdUzxVoLGxLbOGgrOkbbLQ2Tg0d/e
l2qqSVoLJyLcTUsGWihLYMoCg1ObMZbGmazeOyN4PiglGa1SiA2Qt0qNX8oZ2Oh/
F3wRoC1JtplkdDbEGaKa5HRNb2H9xV4ZBaqD7v8sYLEdyOTBDgZDQ1yD1gCNSKXy
jO7i3+J4bic3C8HNa8OuL2tpVOV/aJma4PBLmGsuqLwatDQOQHKj5yXyLxgGcal1
Gp4JeQIOs3F7KDP3RboC
=eNkw
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
