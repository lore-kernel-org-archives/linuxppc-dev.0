Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 18F0DDDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 01:18:05 +1000 (EST)
Date: Wed, 29 Apr 2009 01:17:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tim Abbott <tabbott@MIT.EDU>
Subject: Re: [PATCH 11/14] powerpc: Use macros for .data.page_aligned section.
Message-Id: <20090429011756.6cccbc7d.sfr@canb.auug.org.au>
In-Reply-To: <20090429010753.851e0f59.sfr@canb.auug.org.au>
References: <1240864388-26315-1-git-send-email-tabbott@mit.edu>
	<1240864388-26315-2-git-send-email-tabbott@mit.edu>
	<1240864388-26315-3-git-send-email-tabbott@mit.edu>
	<1240864388-26315-4-git-send-email-tabbott@mit.edu>
	<1240864388-26315-5-git-send-email-tabbott@mit.edu>
	<1240864388-26315-6-git-send-email-tabbott@mit.edu>
	<1240864388-26315-7-git-send-email-tabbott@mit.edu>
	<1240864388-26315-8-git-send-email-tabbott@mit.edu>
	<1240864388-26315-9-git-send-email-tabbott@mit.edu>
	<1240864388-26315-10-git-send-email-tabbott@mit.edu>
	<1240864388-26315-11-git-send-email-tabbott@mit.edu>
	<1240864388-26315-12-git-send-email-tabbott@mit.edu>
	<20090429010753.851e0f59.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__29_Apr_2009_01_17_56_+1000_7t_2EKfvSxU9SVmT"
Cc: Jeff, Denys Vlasenko <vda.linux@googlemail.com>,
	Sam Ravnborg <sam@ravnborg.org>, Waseem,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Arnold <jbarnold@mit.edu>, Anders Kaseorg <andersk@mit.edu>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Tim Abbott <tabbott@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>, Daher <wdaher@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__29_Apr_2009_01_17_56_+1000_7t_2EKfvSxU9SVmT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Apr 2009 01:07:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> This moves the page_aligned section from a common part of the
> vmlinux.lds to a 32 bit only part.  Was that intentional?

Just saw your later patches, so ignore this.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__29_Apr_2009_01_17_56_+1000_7t_2EKfvSxU9SVmT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkn3HiQACgkQjjKRsyhoI8wYnQCgtVLjC0ymSa8ExUYejFYABlnq
xh4AnjxqlGPU3jrnx6yxubkifNykP7IJ
=eakv
-----END PGP SIGNATURE-----

--Signature=_Wed__29_Apr_2009_01_17_56_+1000_7t_2EKfvSxU9SVmT--
