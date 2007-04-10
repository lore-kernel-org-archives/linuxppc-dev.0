Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FCE3DDF0B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 23:44:58 +1000 (EST)
Subject: Re: [PATCH] Build break on ppc64 for 2.6.21-rc6-mm1
From: Johannes Berg <johannes@sipsolutions.net>
To: Srinivasa Ds <srinivasa@in.ibm.com>
In-Reply-To: <200704101820.47509.srinivasa@in.ibm.com>
References: <200704101820.47509.srinivasa@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-tjSVKLJg46V0RiastZOb"
Date: Tue, 10 Apr 2007 15:45:21 +0200
Message-Id: <1176212721.8459.97.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-tjSVKLJg46V0RiastZOb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-10 at 18:20 +0530, Srinivasa Ds wrote:

> Below patch fixes this problem. please let me know comments on this.

+#include <linux/sysdev.h>


Yeah, I heard about that change but didn't have a chance to check it out
yet. Patch looks good to me, of course.

johannes

--=-tjSVKLJg46V0RiastZOb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGG5Tw/ETPhpq3jKURAsexAJ4ohDHy4XFT9+4io0tp3RipW7QTqQCeLrZ1
YNGdAvf7ly6rqunH1FvcmAI=
=7mfY
-----END PGP SIGNATURE-----

--=-tjSVKLJg46V0RiastZOb--
