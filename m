Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4E41C67BCE
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 21:17:55 +1100 (EST)
Date: Thu, 16 Nov 2006 21:17:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 8/9] Make 64-bit cpu features defined on 32-bit
Message-Id: <20061116211759.003f3dbd.sfr@canb.auug.org.au>
In-Reply-To: <20061116072329.12C5067BEA@ozlabs.org>
References: <1163661800.406227.631357998554.qpush@cradle>
	<20061116072329.12C5067BEA@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__16_Nov_2006_21_17_59_+1100_se1l.3H15yljzRGs"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__16_Nov_2006_21_17_59_+1100_se1l.3H15yljzRGs
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2006 18:23:27 +1100 Michael Ellerman <michael@ellerman.id.au> wrote:
>
> It saves #ifdef'ing in callers if we at least define the 64-bit cpu
> features for 32-bit also.

Does it matter that some of the 64 bit feature bit defines are 0 on 32
bit?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__16_Nov_2006_21_17_59_+1100_se1l.3H15yljzRGs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFXDrgFdBgD/zoJvwRAoj0AJ9HV+1G8zBN/KoA2HiuXo8qWjmIdQCfQ2BG
nAy7ILxSk0j8HYFupQEAySM=
=qscX
-----END PGP SIGNATURE-----

--Signature=_Thu__16_Nov_2006_21_17_59_+1100_se1l.3H15yljzRGs--
