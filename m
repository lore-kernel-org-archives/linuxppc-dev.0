Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A707ADDDB6
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 12:09:03 +1000 (EST)
Subject: Re: [PATCH] powerpc: Allow mem=x cmdline to work with 4G+
From: Michael Ellerman <michael@ellerman.id.au>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1241821167-13069-1-git-send-email-beckyb@kernel.crashing.org>
References: <1241821167-13069-1-git-send-email-beckyb@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ik7tr86pb/2NgnnkFSBq"
Date: Mon, 11 May 2009 12:09:02 +1000
Message-Id: <1242007742.7767.29.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ik7tr86pb/2NgnnkFSBq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-05-08 at 17:19 -0500, Becky Bruce wrote:
> We're currently choking on mem=3D4g (and above) due to memory_limit
> being specified as an unsigned long. Make memory_limit
> phys_addr_t to fix this.

Can we not just make it u64 to save the casts?

cheers

--=-ik7tr86pb/2NgnnkFSBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoHiL4ACgkQdSjSd0sB4dIAxQCfVMhmes9ZV3VXjRBzi2HEwXmg
RwQAoMPRv8J7VA/7lP6+n9Hbswl1xwHG
=sHJk
-----END PGP SIGNATURE-----

--=-ik7tr86pb/2NgnnkFSBq--
