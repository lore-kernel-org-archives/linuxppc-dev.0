Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B9005B7B6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 11:36:18 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A117FDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 11:36:18 +1000 (EST)
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te,ud,md}_free_tlb()
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090715074952.A36C7DDDB2@ozlabs.org>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-3sW64rSI2yIG/UuMyqDm"
Date: Thu, 16 Jul 2009 11:36:17 +1000
Message-Id: <1247708177.9851.4.camel@concordia>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
	linuxppc-dev@ozlabs.org, Hugh Dickins <hugh@tiscali.co.uk>,
	linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-3sW64rSI2yIG/UuMyqDm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-07-15 at 17:49 +1000, Benjamin Herrenschmidt wrote:
> Upcoming paches to support the new 64-bit "BookE" powerpc architecture
> will need to have the virtual address corresponding to PTE page when
> freeing it, due to the way the HW table walker works.

> I haven't had a chance to test or even build on most architectures, the
> patch is reasonably trivial but I may have screwed up regardless, I
> appologize in advance, let me know if something is wrong.

Builds for the important architectures, powerpc, ia64, arm, sparc,
sparc64, oh and x86:

http://kisskb.ellerman.id.au/kisskb/head/1976/

(based on your test branch 34f25476)

cheers

--=-3sW64rSI2yIG/UuMyqDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpehAQACgkQdSjSd0sB4dIe4QCgsEWUeUUCjt33SGp2XpLqD/1W
/QsAn37UyeAeK5Msl22yj/kzj0VYowyT
=Lbt0
-----END PGP SIGNATURE-----

--=-3sW64rSI2yIG/UuMyqDm--
