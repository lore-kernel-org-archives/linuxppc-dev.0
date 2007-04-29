Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 57DE0DDEA0
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Apr 2007 11:44:41 +1000 (EST)
Date: Sun, 29 Apr 2007 11:44:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/2] Rename get_property to of_get_property: drivers/net
Message-Id: <20070429114446.31f40a30.sfr@canb.auug.org.au>
In-Reply-To: <4633689E.50900@garzik.org>
References: <20070427145107.4f73e436.sfr@canb.auug.org.au>
	<20070427145508.9c5641a2.sfr@canb.auug.org.au>
	<4633689E.50900@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__29_Apr_2007_11_44_46_+1000_6HKc2Bugqnm4Gh1C"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, akpm@linux-foundation.org,
	paulus@samba.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__29_Apr_2007_11_44_46_+1000_6HKc2Bugqnm4Gh1C
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 28 Apr 2007 11:30:38 -0400 Jeff Garzik <jeff@garzik.org> wrote:
>
> Sorry for your being a football here.

That's OK.

> AFAICS, looking at the two patches, it seems clear they should go in via
> Paulus's tree.  There are clear dependencies, and it is clearly
> arch-specific code.

So can I take this as a future OK for architecture specific network
drivers changes to go through the architecture trees (cc'd to you)?

> If anything, it sounds like I should drop a ucc_geth patch or two from
> my tree.  Is that the case?

No, my patches can wait (there are backward compatibility hacks in place)
so once you have merged your changes with Linus (I am assuming it won't
be to long), we will put these through Paulus' tree.

(The ucc_geth stuff was a pain, but the real kicker (as far as I was
concered) was the ehea changes - parts of that driver have been
completely rewritten in your tree.)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__29_Apr_2007_11_44_46_+1000_6HKc2Bugqnm4Gh1C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGM/imFdBgD/zoJvwRAnI2AJ0SJKscy3o/eaE2P7hY7r9hav6wGwCgjuXJ
EmjHIeulhAWyHY3cl7HG7h4=
=VIzU
-----END PGP SIGNATURE-----

--Signature=_Sun__29_Apr_2007_11_44_46_+1000_6HKc2Bugqnm4Gh1C--
