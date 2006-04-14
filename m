Return-Path: <ncunningham@cyclades.com>
Received: from cust8446.nsw01.dataco.com.au (cust8446.nsw01.dataco.com.au
	[203.171.93.254]) by ozlabs.org (Postfix) with ESMTP id D355467A44
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 16:49:12 +1000 (EST)
From: Nigel Cunningham <ncunningham@cyclades.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
	independent manner V2
Date: Sat, 15 Apr 2006 09:17:04 +1000
References: <20060412232036.18862.84118.sendpatchset@skynet>
In-Reply-To: <20060412232036.18862.84118.sendpatchset@skynet>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5114347.xFTveIS9QW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200604150917.10596.ncunningham@cyclades.com>
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linux-mm@kvack.org,
	ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart5114347.xFTveIS9QW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Mel.

It looks to me like this code could be used by the software suspend code in=
=20
our determinations of what pages to save, particularly in the context of=20
memory hotplug support. Just some food for thought at the moment; I'll see =
if=20
I can come up with a patch when I have some time, but it might help justify=
=20
getting this merged.

Regards,

Nigel

--nextPart5114347.xFTveIS9QW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEQC12N0y+n1M3mo0RAmFYAJ9a9Oz/cpEM/HR9N+6tkCaM9M8ckACgwZhq
qzMYheL6j+4zC3D1vEv6gWM=
=wz0/
-----END PGP SIGNATURE-----

--nextPart5114347.xFTveIS9QW--
